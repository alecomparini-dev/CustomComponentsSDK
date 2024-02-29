//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation
import MapKit
import CoreLocation


public class MapBuilder: BaseBuilder, Map {
    
    public typealias Location = CoreLocation.CLLocation
    public typealias D = MapKit.MKMapViewDelegate

    static public let radius: Double = 500
    
    private weak var mapBuilderOutput: MapBuilderOutput?

    private var userLocation: Location?
    private var pinPointsOfInterest: (flag: Bool, regionRadius:Double, onlyOnce: Bool) = (false, MapBuilder.radius, false )
    private var locationManager: CLLocationManager?
    
    
//  MARK: - INITIALIZERS
    
    private let mapView: MKMapView
    
    public init() {
        self.mapView = MKMapView()
        super.init(mapView)
        configure()
    }
    
    
//  MARK: - GET PROPERTIES
    
    public var get: MKMapView { mapView }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setCenterMap(location: Location, _ regionRadius: Double = MapBuilder.radius) -> Self {
        let coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude ),
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        
        return self
    }
    
    @discardableResult
    public func setShowsUserLocation(_ flag: Bool) -> Self {
        mapView.showsUserLocation = flag
        return self
    }
    
    @discardableResult
    public func setUserTrackingMode(_ mode: K.Map.UserTrackingMode) -> Self {
        mapView.setUserTrackingMode(MKUserTrackingMode(rawValue: mode.rawValue) ?? .none, animated: true)
        return self
    }

    @discardableResult
    public func setShowsCompass(_ flag: Bool) -> Self {
        mapView.showsCompass = flag
        return self
    }
    
    @discardableResult
    public func setPinPointsOfInterest(_ regionRadius: Double = MapBuilder.radius) -> Self {
        pinPointsOfInterest.flag = true
        pinPointsOfInterest.regionRadius = regionRadius
        return self
    }
    
    @discardableResult
    public func setRemoveAllPin() -> Self {
        mapView.removeAnnotations(mapView.annotations)
        return self
    }
    
    
    
//  MARK: - SET DELEGATE
    @discardableResult
    public func setDelegate(_ delegate: D) -> Self {
        mapView.delegate = delegate
        return self
    }
    

//  MARK: - SET OUTPUT
    @discardableResult
    public func setOutput(_ output: MapBuilderOutput) -> Self {
        mapBuilderOutput = output
        return self
    }
    
    
//  MARK: - SHOW MAP
    public func show() {
        
    }
    
    
//  MARK: - PUBLIC AREA

    @discardableResult
    public func checkLocationAuthorization() -> CLAuthorizationStatus {
        locationManager = CLLocationManager()
        
        let authorizationStatus = locationManager?.authorizationStatus
        
        switch authorizationStatus {
            case .authorizedAlways:
                return .authorizedAlways
                
            case .authorizedWhenInUse:
                return .authorizedWhenInUse
                
            case .denied:
                return .denied
            
            case .restricted:
                return .restricted
                
            case .notDetermined:
                locationManager?.requestWhenInUseAuthorization()
                
            case .none:
                return .notDetermined
                
            case .some(_):
                return .notDetermined
        }
        
        return .notDetermined
    }

    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        setShowsUserLocation(true)
        setUserTrackingMode(.follow)
        setShowsCompass(false)
        checkLocationAuthorization()
        configDelegates()
        startUpdatingLocation()
    }
    
    private func configDelegates() {
        setDelegate(self)
        locationManager?.delegate = self
    }
    
    private func configCenterMapByUser(_ regionRadius: Double) {
        if let userLocation {
            setCenterMap(location: userLocation, regionRadius)
        }
    }
    
    private func startUpdatingLocation() {
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
    }

    private func configPinPointsOfInterest() {
        if pinPointsOfInterest.flag && !pinPointsOfInterest.onlyOnce {
//            pinPointsOfInterest.onlyOnce = true
            
//            configCenterMapByUser(pinPointsOfInterest.regionRadius)
            
            guard let userLocation else {return}
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude ) , latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.region = region
            
            let requestPOI = MKLocalPointsOfInterestRequest(coordinateRegion: mapView.region)
            
            let poiFilter = MKPointOfInterestFilter(including: [.foodMarket, .restaurant, .brewery, .cafe, .bakery, .foodMarket, .nightlife, .gasStation, .store])
            
            requestPOI.pointOfInterestFilter = poiFilter
            
            let searchPOI = MKLocalSearch(request: requestPOI)
            
            searchPOI.start { response, error in
                guard let response = response, error == nil else {
                    print("Erro ao obter pontos de interesse: \(error?.localizedDescription ?? "Erro desconhecido")")
                    return
                }
                
                for item in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    
}


//  MARK: - EXTENSION - MKMapViewDelegate
extension MapBuilder: MKMapViewDelegate {
    
    public func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapBuilderOutput?.finishLoadingMap()
        configPinPointsOfInterest()
        print("mapViewDidFinishLoadingMap")
    }
    
    
    public func mapView(_ mapView: T, didSelect view: MKAnnotationView) {
       
    }
    
    public func mapView(_ mapView: T, didDeselect view: MKAnnotationView) {
        
    }
    
    
    
}

//  MARK: - EXTENSION - CLLocationManagerDelegate
extension MapBuilder: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [Location]) {
        userLocation = locations.last
        locationManager?.stopUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Localization error: \(error.localizedDescription)")
    }
    
}
