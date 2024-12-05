//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation
import MapKit
import CoreLocation


public class MapBuilder: BaseBuilder, Map {
    private typealias Title = String
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
    
    private var resultPins = [Title: PlaceMapDTO]()
    private var resultSearchCompletion: [MKLocalSearchCompletion]?
    private var resultPlacesMap = [PlaceMapDTO]()
    
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
    
    public func getResultSearchCount() -> Int { resultPlacesMap.count }

    public func getResultSearch(_ index: Int) -> PlaceMapDTO { resultPlacesMap[index] }
    
    public func getLocationAddress(_ location: CLLocation?) async -> PlaceMapDTO? {
        guard let userLocation else {return nil}
        
        let geocoder = CLGeocoder()
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(userLocation)
            
            guard let placemark = placemarks.first, let location = placemark.location else { return nil }
            
            return PlaceMapDTO(name: placemark.name,
                               street: placemark.thoroughfare,
                               number: placemark.subThoroughfare,
                               neighborhood: placemark.subLocality,
                               city: placemark.locality,
                               UF: placemark.administrativeArea,
                               postalCode: placemark.postalCode,
                               country: placemark.country,
                               coordinate: (lat: location.coordinate.latitude, lon: location.coordinate.latitude))
        } catch {
            return nil
        }
    }
    
    public func getUserLocationAddress() async -> PlaceMapDTO? {
        return await getLocationAddress(userLocation)
    }
    
    public func getPinAddress(title: String) -> PlaceMapDTO? { resultPins[title] }


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
    public func setAnnotationPin(coordinate: (lat: Double, lon: Double), title: String? = "", subTitle: String? = nil, centerView: Bool? = false, autoSelect: Bool? = false) -> Self {
        let annotation = MKPointAnnotation()
            
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon)
        
        annotation.title = title
        
        if let subTitle { annotation.subtitle = subTitle }
        
        mapView.addAnnotation(annotation)
        
        setCenterView(centerView, coordinate)
        
        setAutoSelect(annotation, autoSelect)
    
        return self
    }
    
    private func setCenterView(_ centerView: Bool?, _ coordinate: (lat: Double, lon: Double)) {
        if centerView == false { return }
        
        setCenterMap(location: CLLocation(latitude: coordinate.lat, longitude: coordinate.lon))
    }
    
    private func setAutoSelect(_ annotation: MKAnnotation, _ autoSelect: Bool? = false) {
        if autoSelect == false { return }
        
        mapView.selectAnnotation(annotation, animated: true)
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
    
    public func resetSearchPlaces() {
        resetResultSearch()
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

    private func configPinPointsOfInterest() {
        if !pinPointsOfInterest.flag || pinPointsOfInterest.onlyOnce { return }
        
        pinPointsOfInterest.onlyOnce = true
        
        commonsConfigPin(pinPointsOfInterest.regionRadius)
                    
        let request = MKLocalPointsOfInterestRequest(coordinateRegion: mapView.region)
        
        let poiFilter = MKPointOfInterestFilter(including: pinPointsOfInterest.categories)
        
        request.pointOfInterestFilter = poiFilter
                    
        search(requestPOI: request) { [weak self] response in
            self?.setPinsAndAnnotations(response)
        }
    }
    
    private func configPinNaturalLanguage() {
        if !pinNaturalLanguage.flag || pinNaturalLanguage.onlyOnce { return }
        
        pinNaturalLanguage.onlyOnce = true
        
        commonsConfigPin(pinNaturalLanguage.regionRadius)
            
        searchNaturalLanguage(pinNaturalLanguage.text) { [weak self] response in
            self?.setPinsAndAnnotations(response)
        }
    }
    
    private func setPinsAndAnnotations(_ response: MKLocalSearch.Response) {
        setPins(response)
        
        setAnnotationPinByResponseSearch(response)
    }

    private func setPins(_ response: MKLocalSearch.Response) {
        let placeMap = SearchResponseToPlaceMapDTO.mapper(response)
        
        placeMap.forEach { place in
            guard let title = place.title else { return }
            
            resultPins.updateValue(place, forKey: title)
        }
    }

    private func setAnnotationPinByResponseSearch(_ response: MKLocalSearch.Response) {
        for item in response.mapItems {
            setAnnotationPin(coordinate: (lat: item.placemark.coordinate.latitude, lon: item.placemark.coordinate.longitude),
                             title: item.name,
                             subTitle: item.placemark.title)
        }
    }
    
    private func searchNaturalLanguage(_ text: String, _ region: MKCoordinateRegion? = nil, _ completion: @escaping (_ response: MKLocalSearch.Response) -> Void) {
        let request = MKLocalSearch.Request()
        
        if let region {
            request.region = region
        }
        
        request.resultTypes = [.address, .pointOfInterest]
        
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
    
    private func resetResultSearch() {
        resultSearchCompletion = nil
        resultPlacesMap = []
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
            guard let self else { return }
        
            resetResultSearch()
            
            configMapper(response)
            
            mapBuilderOutput?.fetchPlacesAutoCompleterSuccess(placesMap: resultPlacesMap)
        }
    }
    
    private func fetchPlacesNaturalLanguage(_ index: Int) {
        let response: PlaceMapDTO = resultPlacesMap[index]
        
        let text = makeTextToSearch(response)
        
        let region = createRegion((response.coordinate?.lat, response.coordinate?.lon))
        
        searchNaturalLanguage(text, region) { [weak self] response in
            guard let self else { return }
            
            resetResultSearch()
            
            configMapper(response)
            
            mapBuilderOutput?.fetchPlacesSuccess(placesMap: resultPlacesMap)
        }
    }
    
    private func makeTextToSearch(_ response: PlaceMapDTO) -> String {
        let name = response.name ?? ""
        
        let street = response.street ?? ""
        
        if name.lowercased(with: Locale.current).contains(street.lowercased(with: Locale.current)) {
            return response.subtitle ?? ""
        }
        
        return "\(response.name ?? ""), \(response.subtitle ?? "")"
    }
    
    private func configMapper(_ response: MKLocalSearch.Response) {
        resultPlacesMap = SearchResponseToPlaceMapDTO.mapper(response)
    }
        
    private func createRegion(_ coordinate: (lat: Double?, lon: Double?), _ radius: Double = 50) -> MKCoordinateRegion? {
        guard let lat = coordinate.lat, let lon = coordinate.lon else { return nil }
        
        return MKCoordinateRegion (
            center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
    }
    
    private func isChosenSearchCompletion() -> Bool {
        resultSearchCompletion != nil
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
        
        resetResultSearch()
        
        resultSearchCompletion = completer.results
        
        resultPlacesMap = completer.results.map({ PlaceMapDTO(title: $0.title, subtitle: $0.subtitle) })
        
        mapBuilderOutput?.fetchPlacesAutoCompleterSuccess(placesMap: resultPlacesMap)
    }
    
}
