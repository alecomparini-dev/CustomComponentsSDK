//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation
import MapKit
import CoreLocation

public class MapBuilder: BaseBuilder, Map {
    public typealias MKMapView = MapKit.MKMapView
    public typealias CLLocation = CoreLocation.CLLocation
    public typealias MKMapViewDelegate = MapKit.MKMapViewDelegate

    static public let radius: Double = 500
    
    private var userLocation: CLLocation?
    private var centerMapByUser: (flag: Bool, regionRadius: Double ) = (false, 500 )
    
    private var locationManager: CLLocationManager?
    
    public var get: MKMapView { mapView }
    
    
//  MARK: - INITIALIZERS
    
    private let mapView: MKMapView
    
    public init() {
        self.mapView = MKMapView()
        super.init(mapView)
        configure()
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setCenterMap(location: CLLocation, _ regionRadius: Double = MapBuilder.radius) -> Self {
        let regionRadius: CLLocationDistance = regionRadius
        
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        return self
    }
    
    @discardableResult
    public func setCenterMapByUser(_ regionRadius: Double = MapBuilder.radius) -> Self {
        centerMapByUser = (true, regionRadius)
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
    public func setShowsPointsOfInterest(_ flag: Bool) -> Self {
        return self
    }

    
    
//  MARK: - SET DELEGATE
    
    @discardableResult
    public func setDelegate(_ delegate: MKMapViewDelegate) -> Self {
        mapView.delegate = delegate
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
        startUpdatingLocation()
        configDelegates()
    }
    
    private func configDelegates() {
        setDelegate(self)
        locationManager?.delegate = self
    }
    
    private func configCenterMapByUser() {
        if let userLocation, centerMapByUser.flag {
            setCenterMap(location: userLocation, centerMapByUser.regionRadius)
        }
    }
    
    private func startUpdatingLocation() {
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
    }
}


//  MARK: - EXTENSION - MKMapViewDelegate
extension MapBuilder: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
       
    }
    
    public func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
    }
    
    
    
}

//  MARK: - EXTENSION - CLLocationManagerDelegate
extension MapBuilder: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        locationManager?.stopUpdatingLocation()
        configCenterMapByUser()
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Localization error: \(error.localizedDescription)")
    }
    
}
