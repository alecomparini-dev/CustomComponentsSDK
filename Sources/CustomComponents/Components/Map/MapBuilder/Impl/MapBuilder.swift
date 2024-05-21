//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation
import MapKit
import CoreLocation


public class MapBuilder: BaseBuilder, Map {
    public typealias D = MapKit.MKMapViewDelegate
    public typealias PointOfInterestCategory = MKPointOfInterestCategory
    public typealias Location = CoreLocation.CLLocation
    
    static public let radius: Double = 500
    private weak var mapBuilderOutput: MapBuilderOutput?
    
    private var loadingMap = false
    private var alreadyApplied = false
    private var userLocation: Location?
    private var pinPointsOfInterest: (flag: Bool, categories: [MKPointOfInterestCategory], regionRadius:Double, onlyOnce: Bool) = (false, [], MapBuilder.radius, false )
    private var pinNaturalLanguage: (flag: Bool, text: String, regionRadius:Double, onlyOnce: Bool) = (false, "", MapBuilder.radius, false )
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
    public func setCenterMap(location: Location?, _ regionRadius: Double = MapBuilder.radius) -> Self {
        guard let location else { return self }
        
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
    public func setPinPointsOfInterest(_ categories: [MKPointOfInterestCategory], _ regionRadius: Double = MapBuilder.radius) -> Self {
        pinPointsOfInterest.flag = true
        pinPointsOfInterest.categories = categories
        pinPointsOfInterest.regionRadius = regionRadius
        return self
    }
    
    @discardableResult
    public func setPinNaturalLanguage(_ text: String, _ regionRadius: Double) -> Self {
        pinNaturalLanguage.flag = true
        pinNaturalLanguage.text = text
        pinNaturalLanguage.regionRadius = regionRadius
        return self
    }
    
    @discardableResult
    public func setRemoveAllPin() -> Self {
        mapView.removeAnnotations(mapView.annotations)
        return self
    }
    
    @discardableResult
    public func setAnnotationPin(coordinate: (lat: Double, lon: Double), title: String? = "", subTitle: String? = nil, _ centerView: Bool = false ) -> Self {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon)
        annotation.title = title
        if let subTitle { annotation.subtitle = subTitle }
        self.mapView.addAnnotation(annotation)
        if centerView {
            setCenterMap(location: CLLocation(latitude: coordinate.lat, longitude: coordinate.lon))
        }
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
        applyOnceConfig()
        
        let status = checkLocationAuthorization()
        
        if status == .notDetermined { return }
        
        if !isAuthorized(locationManager) {
            mapBuilderOutput?.localizationNotAuthorized()
            return
        }
    }
    
    private func applyOnceConfig() {
        if alreadyApplied { return }
        alreadyApplied = true
        
        configDelegates()
        startUpdatingLocation()
    }
    
    
    
//  MARK: - PUBLIC AREA
    
    @discardableResult
    public func checkLocationAuthorization() -> CLAuthorizationStatus {
        
        switch locationManager?.authorizationStatus {
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
                return .notDetermined
                
            case .none:
                return .notDetermined
                
            case .some(_):
                return .notDetermined
        }
        
    }
    
    
    
    //  MARK: - PRIVATE AREA
    
    public func configure() {
        setShowsCompass(false)
    }
    
    private func configDelegates() {
        setDelegate(self)
        locationManager = CLLocationManager()
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

    private func commonsConfigPin(_ radius: Double) {
        setShowsUserLocation(true)
        setUserTrackingMode(.none)
        configCenterMapByUser(radius)
    }
    
    private func setAnnotationPinByResponseSearch(_ response: MKLocalSearch.Response) {
        for item in response.mapItems {
            setAnnotationPin(coordinate: (lat: item.placemark.coordinate.latitude, lon: item.placemark.coordinate.longitude), 
                             title: item.name,
                             subTitle: item.placemark.title)
        }
    }
    
    private func configPinPointsOfInterest() {
        if !pinPointsOfInterest.flag || pinPointsOfInterest.onlyOnce { return }
        
        pinPointsOfInterest.onlyOnce = true
        
        commonsConfigPin(pinPointsOfInterest.regionRadius)
                    
        let request = MKLocalPointsOfInterestRequest(coordinateRegion: mapView.region)
        let poiFilter = MKPointOfInterestFilter(including: pinPointsOfInterest.categories)
        request.pointOfInterestFilter = poiFilter
                    
        search(request: request) { [weak self] response in
            self?.setAnnotationPinByResponseSearch(response)
        }
    }
    
    private func configPinNaturalLanguage() {
        if !pinNaturalLanguage.flag || pinNaturalLanguage.onlyOnce { return }
        
        pinNaturalLanguage.onlyOnce = true
        
        commonsConfigPin(pinNaturalLanguage.regionRadius)
            
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = pinNaturalLanguage.text
        
        search(request: request) { [weak self] response in
            self?.setAnnotationPinByResponseSearch(response)
        }
    }
    
    private func search(request: MKLocalSearch.Request, _ completion: @escaping (_ response: MKLocalSearch.Response) -> Void) {
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        searchStart(search, completion)
    }
    
    private func search(request: MKLocalPointsOfInterestRequest, _ completion: @escaping (_ response: MKLocalSearch.Response) -> Void) {
        let search = MKLocalSearch(request: request)
        searchStart(search, completion)
    }
    
    private func searchStart(_ search: MKLocalSearch, _ completion: @escaping (_ response: MKLocalSearch.Response) -> Void) {
        search.start { response, error in
            guard let response = response, error == nil else {
                //TODO: CALL OUTPUT ERROR
                debugPrint(#function, error?.localizedDescription ?? "")
                return
            }
            
            completion(response)
        }
    }
    
    private func isAuthorized(_ manager: CLLocationManager?) -> Bool {
        guard let manager else { return false }
        return manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways
    }
    
    private func configPins() {
        if !loadingMap || userLocation == nil {return}
        configPinPointsOfInterest()
        configPinNaturalLanguage()
    }
    
}


//  MARK: - EXTENSION - MKMapViewDelegate
extension MapBuilder: MKMapViewDelegate {
    
  
    
    public func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if fullyRendered {
            loadingMap = true
            mapBuilderOutput?.finishFullyRenderedMap()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                self?.configPins()
            })
        }
    }
    
    
    public func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
        let title = (annotation.title ?? "") ?? ""
        let subtitle = (annotation.subtitle ?? "") ?? ""
        let coordinate = annotation.coordinate
        
        mapBuilderOutput?.pinSelected(title: title,
                                      subtitle: subtitle,
                                      coordinate: (lat: coordinate.latitude, lon: coordinate.longitude))
    }
    
    public func mapView(_ mapView: T, didDeselect view: MKAnnotationView) {
        
    }
    
    
    
}

//  MARK: - EXTENSION - CLLocationManagerDelegate
extension MapBuilder: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [Location]) {
        if let userLocation = locations.first {
            self.userLocation = userLocation
                
            setCenterMap(location: userLocation)
            
            locationManager?.stopUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        mapBuilderOutput?.loadingMapError(error.localizedDescription)
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if !isAuthorized(manager) {
            mapBuilderOutput?.localizationNotAuthorized()
            return
        }
    }
    
}
