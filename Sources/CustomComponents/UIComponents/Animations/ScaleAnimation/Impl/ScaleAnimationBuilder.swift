//  Created by Alessandro Comparini on 10/05/25.
//

import UIKit

@MainActor
final public class ScaleAnimationBuilder: BaseAnimationBuilder, ScaleAnimation {
    
    private let keyPath = "transform.scale"
    
    public init(component: BaseBuilder) {
        super.init(component: component,
                   keyPathCABasicAnimation: keyPath)
        
    }

    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setScale(_ scale: CGFloat) -> Self {
        super.baseParameters.fromValue = 1
        super.baseParameters.toValue = scale
        return self
    }
    
    public override func startAnimation(_ completion: (() -> Void)? = nil) {
        component?.setHidden(false, animated: true)
        
        super.startAnimation(completion)
    }

}
