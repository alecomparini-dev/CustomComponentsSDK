//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation

public protocol Map {
    associatedtype MKMapView
    associatedtype CLLocation
    associatedtype MKMapViewDelegate
    associatedtype CLAuthorizationStatus
    
    var get: MKMapView {get}
    
    func setCenterMap(location: CLLocation, _ regionRadius: Double) -> Self
    
    func setCenterMapByUser(_ regionRadius: Double) -> Self
    
    func setShowsUserLocation(_ flag: Bool) -> Self
    
    func setShowsCompass(_ flag: Bool) -> Self
    
    func setShowsPointsOfInterest(_ flag: Bool) -> Self
    
    func setUserTrackingMode(_ mode: K.Map.UserTrackingMode) -> Self
    
    func checkLocationAuthorization() -> CLAuthorizationStatus
    
    
//  MARK: - SET DELEGATE
    func setDelegate(_ delegate: MKMapViewDelegate) -> Self
    
    
//  MARK: - SHOW / HIDE MAPS
    func show()
    
    
}
