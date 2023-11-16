//  Created by Alessandro Comparini on 13/11/23.
//

import Foundation

public protocol Neumorphism {
    @discardableResult
    func setReferenceColor(hexColor: String?) -> Self

    @discardableResult
    func setShadowColor(to shadow: K.Neumorphism.Shadow, hexColor: String) -> Self

    @discardableResult
    func setShadowColor(hexColor: String?) -> Self

    @discardableResult
    func setDistance(percent distance: CGFloat) -> Self

    @discardableResult
    func setDistance(to: K.Neumorphism.Shadow, percent distance: CGFloat) -> Self

    @discardableResult
    func setBlur(percent blur: CGFloat) -> Self
    
    @discardableResult
    func setBlur(to: K.Neumorphism.Shadow, percent blur: CGFloat) -> Self
    
    @discardableResult
    func setIntensity(percent intensity: CGFloat) -> Self

    @discardableResult
    func setIntensity(to: K.Neumorphism.Shadow, percent intensity: CGFloat) -> Self
    
    @discardableResult
    func setShape(_ shape: K.Neumorphism.Shape) -> Self

    @discardableResult
    func setLightPosition(_ lightPosition: K.Neumorphism.LightPosition) -> Self
    
    
//  MARK: - APPLY Neumorphis
    @discardableResult
    func apply() -> Self
    
    func removeNeumorphism(_ component: BaseBuilder)
}
