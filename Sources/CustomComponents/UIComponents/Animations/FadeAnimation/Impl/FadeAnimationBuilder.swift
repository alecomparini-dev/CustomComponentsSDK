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
    
    @discardableResult
    public func setFade(in value: CGFloat, out: CGFloat) -> Self {
        super.component?.setAlpha(out)
        super.baseParameters.fromValue = out
        super.baseParameters.toValue = value
        return self
    }
    
    @discardableResult
    public func setFadeIn() -> Self {
        super.component?.setAlpha(0)
        super.baseParameters.fromValue = 0
        super.baseParameters.toValue = 1
        return self
    }
    
    @discardableResult
    public func setFadeOut() -> Self {
        super.component?.setAlpha(1)
        super.baseParameters.fromValue = 1
        super.baseParameters.toValue = 0
        return self
    }
    
}
