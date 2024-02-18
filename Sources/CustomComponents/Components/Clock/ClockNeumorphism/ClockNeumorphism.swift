//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

protocol ClockNeumorphism {
    
    var build: Void { get }
    
    var getClock: ViewBuilder { get }

    var getHours: ViewBuilder { get }

    var getMinutes: ViewBuilder { get }
    
    
    func setColor(hexColor: String) -> Self
    
    func setDisableShadow() -> Self
    
    func setShadowDistance(_ distance: CGFloat) -> Self
    
    func setLightPosition(_ position: K.Neumorphism.LightPosition) -> Self
    
    func setShape(_ shape: K.Neumorphism.Shape) -> Self
    
    func setColonsStyle(_ build: (_ build: ColonsStyleBuilder) -> ColonsStyleBuilder) -> Self
    
}

