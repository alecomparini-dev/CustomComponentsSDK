//  Created by Alessandro Comparini on 10/05/25.
//

import UIKit

@MainActor
final public class ScaleAnimationBuilder: BaseAnimationBuilder, ScaleAnimation {
    
    private let transformScale = "transform.scale"
    
    public init(component: BaseBuilder) {
        super.init(component: component,
                   keyPathCABasicAnimation: transformScale)
    }

    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setScale(_ scale: CGFloat) -> Self {
        super.baseParameters.fromValue = scale
        return self
    }

}
