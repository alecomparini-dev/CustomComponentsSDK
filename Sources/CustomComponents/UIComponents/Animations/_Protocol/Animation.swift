//  Created by Alessandro Comparini on 10/05/25.
//

import UIKit

@MainActor
public protocol Animation {
    var isAnimating: Bool { get }
    
    var component: BaseBuilder? { get }
    
    @discardableResult
    func setRepeatCount(_ count: Float) -> Self
    
    @discardableResult
    func setDuration(_ duration: TimeInterval) -> Self
    
    @discardableResult
    func setAutoReverse(_ autoReverse: Bool) -> Self
    
    @discardableResult
    func setTimingFunction(_ timingFunctionName: CAMediaTimingFunctionName) -> Self
    
    func startAnimation(_ completion: (() -> Void)?)
       
    func stopAnimation(delay: TimeInterval,
                       shouldHide: Bool,
                       completion: (() -> Void)?)
    
}
