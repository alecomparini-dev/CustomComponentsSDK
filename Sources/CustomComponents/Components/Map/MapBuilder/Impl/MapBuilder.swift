//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation
import MapKit
import CoreLocation


public class MapBuilder: BaseBuilder, Map {
    public typealias T = MKMapView
    public typealias MKMapViewDelegate = MapKit.MKMapViewDelegate
    public typealias MKPointOfInterestCategory = MapKit.MKPointOfInterestCategory
    public typealias CLLocation = CoreLocation.CLLocation
    public typealias A = CLAuthorizationStatus
    public typealias C = MKLocalSearchCompletion
    public typealias R = MKLocalSearch.Response
    
    public struct Constant {
        static public let radius: Double = 500
    }

    private var searchCompleter: MKLocalSearchCompleter?
    
    private var resultSearchCompletion: [MKLocalSearchCompletion]?
    private var resultSearchMapDTO = [ResultSearchMapDTO]()
    
    
    private var loadingMap = false
    private var alreadyApplied = false
    private var userLocation: CLLocation?
    private var pinPointsOfInterest: (flag: Bool, categories: [MKPointOfInterestCategory], regionRadius: Double, onlyOnce: Bool) = (false, [], Constant.radius, false )
    private var pinNaturalLanguage: (flag: Bool, text: String, regionRadius: Double, onlyOnce: Bool) = (false, "", Constant.radius, false )
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
    
    public func getResultSearchCount() -> Int { resultSearchMapDTO.count }

    public func getResultSearch(_ index: Int) -> ResultSearchMapDTO { resultSearchMapDTO[index] }
    
    public func getLocationAddress(_ location: CLLocation?) async -> PlacemarkMapDTO? {
        guard let userLocation else {return nil}
        
        let geocoder = CLGeocoder()
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(userLocation)
            
            guard let placemark = placemarks.first, let location = placemark.location else { return nil }
            
            return PlacemarkMapDTO(street: placemark.thoroughfare,
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
    
    public func getUserLocationAddress() async -> PlacemarkMapDTO? {
        return await getLocationAddress(userLocation)
    }
    

//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setCenterMap(location: CLLocation?, _ regionRadius: Double = Constant.radius) -> Self {
        guard let location else { return self }
        
        guard let coordinateRegion = createRegion((location.coordinate.latitude, location.coordinate.longitude), regionRadius) else { return self }
        
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
        
        mapView.addAnnotation(annotation)
        
        if centerView {
            setCenterMap(location: CLLocation(latitude: coordinate.lat, longitude: coordinate.lon))
        }
        
        return self
    }
    
    
//  MARK: - SET DELEGATE
    
    @discardableResult
    public func setDelegate(_ delegate: MKMapViewDelegate) -> Self {
        mapView.delegate = delegate
        return self
    }
    
    
//  MARK: - SET OUTPUT
    
    @discardableResult
    public func setOutput(_ output: any MapBuilderOutput) -> Self {
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
    
    
//  MARK: - PUBLIC AREA
    
    public func fetchPlacesAutoCompleter(queryFragment: String) {
        instantiateMKLocalSearchCompleter()
        searchCompleter?.queryFragment = queryFragment
    }
    
    public func fetchPlaces(index: Int) {
        
        if isChosenSearchCompletion() {
            return fetchPlacesCompletion(index)
        }
        
        fetchPlacesNaturalLanguage(index)
    }
    
    private func isChosenSearchCompletion() -> Bool {
        resultSearchCompletion != nil
    }
    
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
    
    private func configure() {
        setShowsCompass(false)
    }
    
    private func applyOnceConfig() {
        if alreadyApplied { return }
        
        alreadyApplied = true
        
        configDelegates()
        
        startUpdatingLocation()
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
                    
        search(requestPOI: request) { [weak self] response in
            self?.setAnnotationPinByResponseSearch(response)
        }
    }
    
    private func configPinNaturalLanguage() {
        if !pinNaturalLanguage.flag || pinNaturalLanguage.onlyOnce { return }
        
        pinNaturalLanguage.onlyOnce = true
        
        commonsConfigPin(pinNaturalLanguage.regionRadius)
            
        searchNaturalLanguage(pinNaturalLanguage.text) { [weak self] response in
            self?.setAnnotationPinByResponseSearch(response)
        }
    }
    
    private func searchNaturalLanguage(_ text: String, _ region: MKCoordinateRegion? = nil, _ completion: @escaping (_ response: MKLocalSearch.Response) -> Void) {
        let request = MKLocalSearch.Request()
        
        if let region { request.region = region }
        
        request.naturalLanguageQuery = text
        
        search(request: request) { response in
            completion(response)
        }
    }
    
    private func search(requestCompletion request: MKLocalSearchCompletion, _ completion: @escaping (_ response: MKLocalSearch.Response) -> Void) {
        let searchRequest = MKLocalSearch.Request(completion: request)
        
        let search = MKLocalSearch(request: searchRequest)
        
        searchStart(search, completion)
    }
    
    private func search(request: MKLocalSearch.Request, _ completion: @escaping (_ response: MKLocalSearch.Response) -> Void) {
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        searchStart(search, completion)
    }
    
    private func search(requestPOI request: MKLocalPointsOfInterestRequest, _ completion: @escaping (_ response: MKLocalSearch.Response) -> Void) {
        let search = MKLocalSearch(request: request)
     
        searchStart(search, completion)
    }
    
    private func searchStart(_ search: MKLocalSearch, _ completion: @escaping (_ response: MKLocalSearch.Response) -> Void) {
        search.start { response, error in
            guard let response = response, error == nil else {
                return debugPrint(#function, error?.localizedDescription ?? "")
            }
            
            completion(response)
        }
    }
    
    private func instantiateMKLocalSearchCompleter() {
        if searchCompleter != nil {return}
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
        searchCompleter?.resultTypes = [.query, .address, getPhysicalFeatureAndPOI()]
    }
    
    private func resetResultSearchCompletion() {
        resultSearchCompletion = nil
    }
    
    private func getPhysicalFeatureAndPOI() -> MKLocalSearchCompleter.ResultType {
        if #available(iOS 18.0, *) {
            return [.physicalFeature, .pointOfInterest]
        }
        return .pointOfInterest
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
 
    private func fetchPlacesCompletion(_ index: Int) {
        guard let resultCompletion = resultSearchCompletion?[index] else {return}
        
        search(requestCompletion: resultCompletion) { [weak self] response in
            guard let self else {return}
        
            resetResultSearchCompletion()
            
            resultSearchMapDTO = SearchResponseToResultSearchMapDTO.mapper(response)
            
            mapBuilderOutput?.fetchSearchSuccess(resultSearchMapDTO: resultSearchMapDTO)
        }
    }
    
    private func fetchPlacesNaturalLanguage(_ index: Int) {
        let response: ResultSearchMapDTO = resultSearchMapDTO[index]
        
        let text = "\(response.name ?? "") \(response.subtitle ?? "")"
        
        let region = createRegion((response.coordinate?.lat, response.coordinate?.lon))
        
        searchNaturalLanguage(text, region) { [weak self] response in
            guard let self else {return}
        
            resetResultSearchCompletion()
            
            resultSearchMapDTO = SearchResponseToResultSearchMapDTO.mapper(response)
            
            mapBuilderOutput?.fetchSearchSuccess(resultSearchMapDTO: resultSearchMapDTO)
        }
    }
        
    private func createRegion(_ coordinate: (lat: Double?, lon: Double?), _ radius: Double = 100) -> MKCoordinateRegion? {
        guard let lat = coordinate.lat, let lon = coordinate.lon else { return nil }
        
        return MKCoordinateRegion (
            center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
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
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
        
        if isAuthorized(manager) {
            mapBuilderOutput?.localizationAuthorized()
        }
    }
    
}



//  MARK: - EXTENSION - MKLocalSearchCompleterDelegate

extension MapBuilder: MKLocalSearchCompleterDelegate {
    
    public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        if completer.isSearching { return }
        
        resetResultSearchCompletion()
        
        resultSearchCompletion = completer.results
        
        resultSearchMapDTO = completer.results.map({ ResultSearchMapDTO(title: $0.title, subtitle: $0.subtitle) })
        
        mapBuilderOutput?.fetchSearchSuccess(resultSearchMapDTO: resultSearchMapDTO)
    }
    
}
