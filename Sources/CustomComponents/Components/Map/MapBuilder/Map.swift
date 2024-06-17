//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation

@MainActor
public protocol Map {
    associatedtype T
    associatedtype D
    associatedtype POI
    associatedtype L
    associatedtype A
    
    
//  MARK: - GET PROPERTIES
    
    var get: T {get}
    
    func getLocationAddress(_ location: L?) async -> PlacemarkMap?
    
    func getUserLocationAddress() async -> PlacemarkMap?
    
    func searchPlaces(_ queryFragment: String)
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    func setCenterMap(location: L?, _ regionRadius: Double) -> Self
    
    @discardableResult
    func setShowsUserLocation(_ flag: Bool) -> Self
    
    @discardableResult
    func setShowsCompass(_ flag: Bool) -> Self
    
    @discardableResult
    func setRemoveAllPin() -> Self
    
    @discardableResult
    func setPinPointsOfInterest(_ categories: [POI], _ regionRadius: Double) -> Self
    
    @discardableResult
    func setPinNaturalLanguage(_ text: String, _ regionRadius: Double) -> Self
    
    @discardableResult
    func setAnnotationPin(coordinate: (lat: Double, lon: Double), title: String?, subTitle: String?, _ centerView: Bool) -> Self
        
    @discardableResult
    func setUserTrackingMode(_ mode: K.Map.UserTrackingMode) -> Self
    
    @discardableResult
    func checkLocationAuthorization() -> A
    
    
//  MARK: - SET DELEGATE
    
    func setDelegate(_ delegate: D) -> Self

    
//  MARK: - SET OUTPUT
    
    func setOutput(_ output: MapBuilderOutput) -> Self

    
//  MARK: - SHOW / HIDE MAPS
    
    func show()
    
    
}
