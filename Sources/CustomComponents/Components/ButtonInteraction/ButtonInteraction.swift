//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation

public protocol ButtonInteraction {
    
    var tapped: Void { get }
    var pressed: Void { get }
    var unpressed: Void { get }
    var isPressed: Bool { get }
    
    @discardableResult
    func setColor(hexColor: String ) -> Self
    
    @discardableResult
    func setShadowTapped(_ shadow: ShadowBuilder) -> Self
    
    @discardableResult
    func setShadowPressed(_ shadow: ShadowBuilder) -> Self
    
    @discardableResult
    func setEnabledInteraction(_ enabled: Bool) -> Self
    
    @discardableResult
    func setDurationAnimationTapped(_ duration: Double) -> Self
    
}
