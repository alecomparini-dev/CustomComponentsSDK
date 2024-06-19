//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation
import MapKit
import CoreLocation


@MainActor
public class MapBuilder: BaseBuilder, Map {
    public typealias T = MKMapView
    public typealias D = MapKit.MKMapViewDelegate
    public typealias POI = MKPointOfInterestCategory
    public typealias L = CoreLocation.CLLocation
    public typealias A = CLAuthorizationStatus
    
    public struct Constant {
        static public let radius: Double = 500
    }
    
    private var searchCompleter: MKLocalSearchCompleter?
    
    private var loadingMap = false
    private var alreadyApplied = false
    private var userLocation: L?
    private var pinPointsOfInterest: (flag: Bool, categories: [MKPointOfInterestCategory], regionRadius:Double, onlyOnce: Bool) = (false, [], Constant.radius, false )
    private var pinNaturalLanguage: (flag: Bool, text: String, regionRadius:Double, onlyOnce: Bool) = (false, "", Constant.radius, false )
    private var locationManager: CLLocationManager?

    
//  MARK: - PROTOCOLS
    
    private weak var mapBuilderOutput: MapBuilderOutput?
    
    
    //  MARK: - INITIALIZERS
    
    private let mapView: MKMapView
    
    public init() {
        self.mapView = MKMapView()
        super.init(mapView)
        configure()
    }
    
    
    //  MARK: - GET PROPERTIES
    
    public var get: MKMapView { mapView }
    
    public func getLocationAddress(_ location: L?) async -> PlacemarkMap? {
        guard let userLocation else {return nil}
        
        let geocoder = CLGeocoder()
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(userLocation)
            
            guard let placemark = placemarks.first, let location = placemark.location else { return nil }

            return PlacemarkMap(street: placemark.thoroughfare,
                                addressNumber: placemark.subThoroughfare,
                                neighborhood: placemark.subLocality,
                                postalCode: placemark.postalCode,
                                city: placemark.locality,
                                state: placemark.administrativeArea,
                                country: placemark.country,
                                coordinate: (lat: location.coordinate.latitude, lon: location.coordinate.latitude))
        } catch {
            return nil
        }
    }
    
    public func getUserLocationAddress() async -> PlacemarkMap? {
        return await getLocationAddress(userLocation)
    }
    
    public func searchPlaces(_ queryFragment: String) {
        instantiateMKLocalSearchCompleter()
        searchCompleter?.queryFragment = queryFragment
    }
    
    private func instantiateMKLocalSearchCompleter() {
        if searchCompleter != nil {return}
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
    }

    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setCenterMap(location: L?, _ regionRadius: Double = Constant.radius) -> Self {
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
    public func setPinPointsOfInterest(_ categories: [MKPointOfInterestCategory], _ regionRadius: Double = Constant.radius) -> Self {
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
    
    private func getAnnotationData(_ annotation: any MKAnnotation) -> (title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        let title = (annotation.title ?? "") ?? ""
        let subtitle = (annotation.subtitle ?? "") ?? ""
        let coordinate = annotation.coordinate
        return (title, subtitle, coordinate)
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
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let viewAnnotation = view.annotation else {return}
        
        let annotation = getAnnotationData(viewAnnotation)
        
        mapBuilderOutput?.pinSelected(title: annotation.title,
                                      subtitle: annotation.subtitle,
                                      coordinate: (lat: annotation.coordinate.latitude, lon: annotation.coordinate.longitude))
    }
    
    public func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let viewAnnotation = view.annotation else {return}
        
        let annotation = getAnnotationData(viewAnnotation)
        
        mapBuilderOutput?.pinDeselected(title: annotation.title,
                                        subtitle: annotation.subtitle,
                                        coordinate: (lat: annotation.coordinate.latitude, lon: annotation.coordinate.longitude))

    }
       
}


//  MARK: - EXTENSION - CLLocationManagerDelegate

extension MapBuilder: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [L]) {
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



//  MARK: - EXTENSION - MKLocalSearchCompleterDelegate

extension MapBuilder: MKLocalSearchCompleterDelegate {
    
    public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        var resultCompleter: [(title: String, subtitle: String)] = []
        
        completer.results.forEach { result in
            resultCompleter.append((result.title, result.subtitle))
        }
        
        mapBuilderOutput?.searchPlaces(resultCompleter)
    }
    
    
    
}
