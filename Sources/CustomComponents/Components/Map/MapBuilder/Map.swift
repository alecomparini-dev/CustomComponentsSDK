//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation


public protocol Map {
    associatedtype T
    associatedtype MKMapViewDelegate
    associatedtype MKPointOfInterestCategory
    associatedtype CLLocation
    associatedtype A
    associatedtype C
    associatedtype R
    
    
//  MARK: - GET PROPERTIES
    
    var get: T {get}
        
    func getResultSearch(_ index: Int) -> PlaceMapDTO
    
    func getResultSearchCount() -> Int
    
    func getLocationAddress(_ location: CLLocation?) async -> PlaceMapDTO?
    
    func getUserLocationAddress() async -> PlaceMapDTO?
    
    func getPinAddress(title: String) -> PlaceMapDTO?
    
    
//  MARK: - FETCH
    
    func fetchPlacesAutoCompleter(queryFragment: String)
    
    func fetchPlaces(index: Int)
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    func setCenterMap(location: CLLocation?, _ regionRadius: Double) -> Self
    
    @discardableResult
    func setShowsUserLocation(_ flag: Bool) -> Self
    
    @discardableResult
    func setShowsCompass(_ flag: Bool) -> Self
    
    @discardableResult
    func setRemoveAllPin() -> Self
    
    @discardableResult
    func setPinPointsOfInterest(_ categories: [MKPointOfInterestCategory], _ regionRadius: Double) -> Self
    
    @discardableResult
    func setPinNaturalLanguage(_ text: String, _ regionRadius: Double) -> Self
    
    @discardableResult
    func setAnnotationPin(coordinate: (lat: Double, lon: Double), title: String?, subTitle: String?, centerView: Bool?, autoSelect: Bool?) -> Self
        
    @discardableResult
    func setUserTrackingMode(_ mode: K.Map.UserTrackingMode) -> Self
    
    
//  MARK: - FUNCTIONS

    func resetSearchPlaces()
    
    func checkLocationAuthorization() -> A
    
    
//  MARK: - SET DELEGATE
    
    func setDelegate(_ delegate: MKMapViewDelegate) -> Self

    
//  MARK: - SET OUTPUT
    
    func setOutput(_ output: MapBuilderOutput) -> Self

    
//  MARK: - SHOW / HIDE MAPS
    
    func show()
    
}
