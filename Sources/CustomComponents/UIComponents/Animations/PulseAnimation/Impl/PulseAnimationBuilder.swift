//  Created by Alessandro Comparini on 10/05/25.
//

import UIKit

@MainActor
final public class PulseAnimationBuilder: PulseAnimation {
    private let pulse = CABasicAnimation(keyPath: "transform.scale")
    private let animationKey = "pulseAnimation"
    
    private var _isAnimating: Bool = false
    
    private var duration: TimeInterval = 0.6
    private var delay: TimeInterval = .zero
    private var autoReverse: Bool = true
    private var scale: CGFloat = 1.2
    private var repeatCount: Float = .infinity
    private var timingFunction = CAMediaTimingFunction(name: .linear)
    
    private weak var component: BaseBuilder?
    
    public init(component: BaseBuilder) {
        self.component = component
    }
    
    
//  MARK: - GET PROPERTIES

    public var isAnimating: Bool { _isAnimating }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setScale(_ scale: CGFloat) -> Self {
        self.scale = scale
        return self
    }
    
    @discardableResult
    public func setRepeatCount(_ count: Float) -> Self {
        repeatCount = count
        return self
    }
    
    @discardableResult
    public func setAnimate(duration: TimeInterval) -> Self {
        self.duration = duration
        return self
    }
    
    @discardableResult
    public func setAnimate(delay: TimeInterval) -> Self {
        self.delay = delay
        return self
    }
    
    @discardableResult
    public func setAnimate(autoReverse: Bool) -> Self {
        self.autoReverse = autoReverse
        return self
    }
    
    @discardableResult
    public func setTimingFunction(name: CAMediaTimingFunctionName) -> Self {
        timingFunction = CAMediaTimingFunction(name: name)
        return self
    }
        
    public func startAnimation(_ completion: (() -> Void)? = nil) {
        component?.setHidden(false, animated: true)
 
        setStartAnimation()
        
        component?.baseView.layer.add(pulse, forKey: animationKey)
        
        _isAnimating = true
        
        completion?()
    }
    
    public func stopAnimation(delay: TimeInterval = .zero,
                              shouldHide: Bool = false,
                              completion: (() -> Void)? = nil) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: { [weak self] in
            guard let self else { return }
            
            component?.setHidden(shouldHide, animated: true)
        
            component?.baseView.layer.removeAnimation(forKey: animationKey)
            
            _isAnimating = false
            
            completion?()
        })
        
    }
    
    
    
//  MARK: - PRIVATE AREA
    
    private func setStartAnimation() {
        guard let self else { return }
        pulse.fromValue = 1.0
        pulse.toValue = scale
        pulse.duration = duration
        pulse.autoreverses = autoReverse
        pulse.repeatCount = repeatCount
        pulse.timingFunction = timingFunction
    }

        
}
