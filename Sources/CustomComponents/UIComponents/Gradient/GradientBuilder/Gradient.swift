//  Created by Alessandro Comparini on 09/11/23.
//

import Foundation

@MainActor
public protocol Gradient {
    associatedtype T

    var get: T? { get }
    
    @discardableResult
    func setGradientColors(hexColors: [String]) -> Self
    
    @discardableResult
    func setReferenceColor(referenceHexColor: String, percentageGradient: CGFloat) -> Self
    
    @discardableResult
    func setAxialGradient(_ direction: K.Gradient.Direction ) -> Self
    
    @discardableResult
    func setConicGradient(_ startPoint: CGPoint) -> Self
    
    @discardableResult
    func setRadialGradient(startPoint: CGPoint, _ endPoint: CGPoint?) -> Self
    
    @discardableResult
    func setOpacity(_ opacity: Float) -> Self
    
    @discardableResult
    func setID(_ id: String) -> Self

    
    func removeGradient()
    
    
//  MARK: - APPLY GRADIENT
    @discardableResult
    func apply() -> Self
}
