//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation
import MapKit
import CoreLocation

public class MapBuilder: BaseBuilder, Map {
    public typealias MKMapView = MapKit.MKMapView
    public typealias CLLocation = CoreLocation.CLLocation
    public typealias MKMapViewDelegate = MapKit.MKMapViewDelegate
    
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
    public func setCenterMap(location: CLLocation, _ regionRadius: Double = 1000) -> Self {
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
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        setShowsUserLocation(true)
        setUserTrackingMode(.follow)
        setShowsCompass(false)
        setDelegate(self)
    }
    
    
}


//  MARK: - EXTENSION - MKMapViewDelegate
extension MapBuilder: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("view:", view)
    }
    
    public func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
        print("annotation:", annotation)
    }
    
    
}
