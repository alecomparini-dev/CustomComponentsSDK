//  Created by Alessandro Comparini on 10/05/25.
//

import UIKit

@MainActor
final public class PulseAnimationBuilder: PulseAnimation {
    private var _isAnimating: Bool = false
    private var duration: TimeInterval = 0.6
    private var delay: TimeInterval = .zero
    private var options: UIView.AnimationOptions = [.allowUserInteraction]
    private var scale: (scaleX: CGFloat, y: CGFloat) = (1.2, 1.2)
    
    private let component: BaseBuilder
    
    public init(component: BaseBuilder) {
        self.component = component
        configure()
    }
    
    
//  MARK: - GET PROPERTIES

    public var isAnimating: Bool { _isAnimating }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setScalePulse(scaleX: CGFloat, y: CGFloat) -> Self {
        scale.scaleX = scaleX
        scale.y = y
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
    public func setAnimate(options: UIView.AnimationOptions) -> Self {
        self.options.insert(options)
        return self
    }
    
    public func startAnimation(_ completion: (() -> Void)? = nil) {
        _isAnimating = true
        
        component.setHidden(false, animated: true)
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: options,
                       animations: { [weak self] in
            guard let self else { return }
            
            component.baseView.transform = CGAffineTransform(scaleX: scale.scaleX,
                                                             y: scale.y)
            
        }, completion: { [weak self] bool in
            if bool {
                completion?()
                self?.component.baseView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        })
    }
    
    public func stopAnimation(after : TimeInterval = .zero,
                              shouldHide: Bool = false,
                              completion: (() -> Void)? = nil) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: { [weak self] in
            guard let self else { return }
            
            component.baseView.layer.removeAllAnimations()
            
            component.setHidden(shouldHide, animated: true)
            
            _isAnimating = false
            
            completion?()
        })
        
        
    }
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        setAnimate(options: .repeat)
        setAnimate(options: .autoreverse)
    }
        
}
