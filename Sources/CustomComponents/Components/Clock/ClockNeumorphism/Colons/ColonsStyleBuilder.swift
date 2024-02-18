//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

class ColonsStyleBuilder {
    
    private var colon: ColonModel!
    
    public var get: ColonModel { colon }
    
    
//  MARK: - SET PROPERTIES

    @discardableResult
    func setShape(_ shape: K.Neumorphism.Shape) -> Self {
        colon.shape = shape
        return self
    }

    @discardableResult
    func setRadius(_ radius: CGFloat) -> Self {
        colon.radius = radius
        return self
    }
    
    @discardableResult
    func setColor(hexColor: String) -> Self {
        if !hexColor.isHexColor() { return self }
        colon.hexColor = hexColor
        return self
    }
    
    @discardableResult
    func setDisableShadow() -> Self {
        colon.isShadow = false
        return self
    }
    
    @discardableResult
    func setShadowDistance(_ distance: CGFloat) -> Self {
        colon.shadowDistance = distance
        return self
    }
    
    @discardableResult
    func setLightPosition(_ position: K.Neumorphism.LightPosition) -> Self {
        colon.lightPosition = position
        return self
    }
    
}
