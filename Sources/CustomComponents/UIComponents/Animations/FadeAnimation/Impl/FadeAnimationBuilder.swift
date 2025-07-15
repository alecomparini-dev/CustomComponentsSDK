//  Created by Alessandro Comparini on 15/07/25.
//

import UIKit

@MainActor
final public class FadeAnimationBuilder: BaseAnimationBuilder, FadeAnimation {
    private let keyPath = "opacity"
    
    public init(component: BaseBuilder) {
        super.init(component: component,
                   keyPathCABasicAnimation: keyPath)
    }

    
//  MARK: - SET PROPERTIES
    
    public func setFade(in value: CGFloat = 1, out: CGFloat = 0) {
        super.baseParameters.fromValue = out
        super.baseParameters.toValue = value
    }
    
}
