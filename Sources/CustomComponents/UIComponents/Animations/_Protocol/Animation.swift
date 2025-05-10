//  Created by Alessandro Comparini on 10/05/25.
//

import UIKit

@MainActor
public protocol Animation {
    var isAnimating: Bool { get }
        
    @discardableResult
    func setAnimate(duration: TimeInterval) -> Self
    
    @discardableResult
    func setAnimate(delay: TimeInterval) -> Self
    
    @discardableResult
    func setAnimate(options: UIView.AnimationOptions) -> Self
    
    func startAnimation(_ completion: (() -> Void)?)
    
    func stopAnimation(_ after: TimeInterval,
                       _ shouldHide: Bool,
                       _ completion: (() -> Void)?)
}
