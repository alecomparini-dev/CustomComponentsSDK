//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

@MainActor
public class ColonsStyleBuilder {
    
    
    public var get: ColonModel { colon }
    
    private var colon: ColonModel
    
    public init() {
        self.colon = ColonModel()
    }
    
    
//  MARK: - SET PROPERTIES

    @discardableResult
    public func setShape(_ shape: K.Neumorphism.Shape) -> Self {
        colon.shape = shape
        return self
    }

    @discardableResult
    public func setRadius(_ radius: CGFloat) -> Self {
        colon.radius = radius
        return self
    }
    
    @discardableResult
    public func setColor(hexColor: String) -> Self {
        if !hexColor.isHexColor() { return self }
        colon.hexColor = hexColor
        return self
    }
    
    @discardableResult
    public func setDisableShadow() -> Self {
        colon.isShadow = false
        return self
    }
    
    @discardableResult
    public func setShadowDistance(_ distance: CGFloat) -> Self {
        colon.shadowDistance = distance
        return self
    }
    
    @discardableResult
    public func setLightPosition(_ position: K.Neumorphism.LightPosition) -> Self {
        colon.lightPosition = position
        return self
    }
    
    @discardableResult
    public func setShadowColor(hexColor: String) -> Self {
        colon.shadowHexColor = hexColor
        return self
    }
    
}
