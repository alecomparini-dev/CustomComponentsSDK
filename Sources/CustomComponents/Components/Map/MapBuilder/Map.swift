//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation

@MainActor
public protocol Map {
    associatedtype T
    associatedtype D
    associatedtype PointOfInterestCategory
    associatedtype Location
    associatedtype AuthorizationStatus
    
    var get: T {get}
    
    @discardableResult
    func setCenterMap(location: Location?, _ regionRadius: Double) -> Self
    
    @discardableResult
    func setShowsUserLocation(_ flag: Bool) -> Self
    
    @discardableResult
    func setShowsCompass(_ flag: Bool) -> Self
    
    @discardableResult
    func setRemoveAllPin() -> Self
    
    @discardableResult
    func setPinPointsOfInterest(_ categories: [PointOfInterestCategory], _ regionRadius: Double) -> Self
    
    @discardableResult
    func setPinNaturalLanguage(_ text: String, _ regionRadius: Double) -> Self
    
    @discardableResult
    func setAnnotationPin(coordinate: (lat: Double, lon: Double), title: String?, subTitle: String?, _ centerView: Bool) -> Self
        
    @discardableResult
    func setUserTrackingMode(_ mode: K.Map.UserTrackingMode) -> Self
    
    @discardableResult
    func checkLocationAuthorization() -> AuthorizationStatus
    
    
//  MARK: - SET DELEGATE
    func setDelegate(_ delegate: D) -> Self

    
//  MARK: - SET OUTPUT
    func setOutput(_ output: MapBuilderOutput) -> Self

    
//  MARK: - SHOW / HIDE MAPS
    func show()
    
    
}
