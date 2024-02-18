//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

public struct ColonModel {
    public var radius: CGFloat
    public var hexColor: String
    public var isShadow: Bool
    public var shadowDistance: CGFloat
    public var lightPosition: K.Neumorphism.LightPosition
    public var shape: K.Neumorphism.Shape
    
    public init(radius: CGFloat = 6,
                hexColor: String = "#00e0c6", 
                isShadow: Bool = true,
                shadowDistance: CGFloat = 10,
                lightPosition: K.Neumorphism.LightPosition = .leftTop,
                shape: K.Neumorphism.Shape = .flat) {
        self.radius = radius
        self.hexColor = hexColor
        self.isShadow = isShadow
        self.shadowDistance = shadowDistance
        self.lightPosition = lightPosition
        self.shape = shape
    }
}
