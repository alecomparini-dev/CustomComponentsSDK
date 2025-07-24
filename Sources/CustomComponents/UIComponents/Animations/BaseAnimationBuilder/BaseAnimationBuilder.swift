//  Created by Alessandro Comparini on 15/07/25.
//

import UIKit

@MainActor
open class BaseAnimationBuilder: Animation {
    
    public var baseParameters: BaseAnimationParameters = BaseAnimationParameters()
    private var animationKey: String = ""
    private var _isAnimating: Bool = false
    private var basicAnimation: CABasicAnimation!
    
    
//  MARK: - INITIALIAZERS
    
    private weak var _component: BaseBuilder?
    
    private let keyPathCABasicAnimation: String
    
    public init(component: BaseBuilder? = nil,
                keyPathCABasicAnimation: String) {
        self._component = component
        self.keyPathCABasicAnimation = keyPathCABasicAnimation
        configure()
    }
    

//  MARK: - GET PROPERTIES

    public var isAnimating: Bool { _isAnimating }
    
    public var component: BaseBuilder? { _component }
    

//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setRepeatCount(_ count: Float) -> Self {
        baseParameters.repeatCount = count
        return self
    }
    
    @discardableResult
    public func setDuration(_ duration: TimeInterval) -> Self {
        baseParameters.duration = duration
        return self
    }
    
    @discardableResult
    public func setAutoReverse(_ autoReverse: Bool) -> Self {
        baseParameters.autoReverse = autoReverse
        return self
    }
    
    @discardableResult
    public func setTimingFunction(_ timingFunctionName: CAMediaTimingFunctionName) -> Self {
        baseParameters.timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        return self
    }
    
    
//  MARK: - CONTROL ANIMATION
    
    public func startAnimation(_ completion: (() -> Void)? = nil) {
        if _isAnimating { return }
 
        setStartAnimation()
        
        component?.baseView.layer.add(basicAnimation, forKey: animationKey)
        
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
    
    private func configure() {
        basicAnimation = CABasicAnimation(keyPath: keyPathCABasicAnimation)
        animationKey = keyPathCABasicAnimation
    }
    
    private func setStartAnimation() {
        basicAnimation.fromValue = baseParameters.fromValue
        basicAnimation.toValue = baseParameters.toValue
        basicAnimation.duration = baseParameters.duration
        basicAnimation.autoreverses = baseParameters.autoReverse
        if let repeatCount = baseParameters.repeatCount {
            basicAnimation.repeatCount = repeatCount
        }
        basicAnimation.timingFunction = baseParameters.timingFunction
    }
    
}
