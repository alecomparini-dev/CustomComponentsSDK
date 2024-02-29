//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation

public protocol Map {
    associatedtype T
    associatedtype D
    associatedtype PointOfInterestCategory
    associatedtype Location
    associatedtype AuthorizationStatus
    
    var get: T {get}
    
    func setCenterMap(location: Location, _ regionRadius: Double) -> Self
       
    func setShowsUserLocation(_ flag: Bool) -> Self
    
    func setShowsCompass(_ flag: Bool) -> Self
    
    func setRemoveAllPin() -> Self
    
    func setPinPointsOfInterest(_ categories: [PointOfInterestCategory], _ regionRadius: Double) -> Self
    
    func setUserTrackingMode(_ mode: K.Map.UserTrackingMode) -> Self
    
    func checkLocationAuthorization() -> AuthorizationStatus
    
    
//  MARK: - SET DELEGATE
    func setDelegate(_ delegate: D) -> Self

    
//  MARK: - SET OUTPUT
    func setOutput(_ output: MapBuilderOutput) -> Self

    
//  MARK: - SHOW / HIDE MAPS
    func show()
    
    
}
