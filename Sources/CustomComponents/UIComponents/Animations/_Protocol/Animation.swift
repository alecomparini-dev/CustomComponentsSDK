//  Created by Alessandro Comparini on 10/05/25.
//

import UIKit

@MainActor
public protocol Animation {
    var isAnimating: Bool { get }
    
    @discardableResult
    func setRepeatCount(_ count: Float) -> Self
    
    @discardableResult
    func setAnimate(duration: TimeInterval) -> Self
    
    @discardableResult
    func setAnimate(delay: TimeInterval) -> Self
    
    @discardableResult
    func setAnimate(autoReverse: Bool) -> Self
    
    @discardableResult
    func setTimingFunction(name: CAMediaTimingFunctionName) -> Self
    
    func startAnimation(_ completion: (() -> Void)?)
       
    func stopAnimation(delay: TimeInterval,
                       shouldHide: Bool,
                       completion: (() -> Void)?)
    
}
