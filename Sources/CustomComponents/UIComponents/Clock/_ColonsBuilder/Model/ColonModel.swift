//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

public struct ColonModel {
    public var radius: CGFloat
    public var hexColor: String
    public var isShadow: Bool
    public var shadowDistance: CGFloat
    public var shadowHexColor: String
    public var lightPosition: UIK.Neumorphism.LightPosition
    public var shape: UIK.Neumorphism.Shape
    
    public init(radius: CGFloat = 5,
                hexColor: String = "#00e0c6",
                isShadow: Bool = true,
                shadowDistance: CGFloat = 6,
                shadowHexColor: String = "#282828",
                lightPosition: UIK.Neumorphism.LightPosition = .leftTop,
                shape: UIK.Neumorphism.Shape = .flat) {
        self.radius = radius
        self.hexColor = hexColor
        self.isShadow = isShadow
        self.shadowDistance = shadowDistance
        self.shadowHexColor = shadowHexColor
        self.lightPosition = lightPosition
        self.shape = shape
    }
}
