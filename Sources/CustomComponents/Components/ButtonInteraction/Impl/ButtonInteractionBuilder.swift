//  Created by Alessandro Comparini on 15/11/23.
//

import UIKit

@MainActor
open class ButtonInteractionBuilder: NSObject, ButtonInteraction {
    private let identifier = String(describing: ButtonInteractionBuilder.self)
    private let shadowOpacityProperty = K.Button.Interaction.shadowOpacityProperty
    
    private var duration: Double = 0.2
    private var shadowTapped: ShadowBuilder?
    private var shadowPressed: ShadowBuilder?
    private var shadowLayer: CALayer = CALayer()
    private var animation: CABasicAnimation!
    
    private var _isPressed: Bool = false
    private var enabledInteraction: Bool = true
    private var colorInteraction: UIColor = Theme.shared.currentTheme.primary.adjustBrightness(20)
    
    
//  MARK: - INITIALIZERS
    
    private weak var component: UIView?
    
    public init(component: UIView) {
        self.component = component
        super.init()
    }
    
    
//  MARK: - GET PROPERTIES
    public var isPressed: Bool { _isPressed }

    public var tapped: Void {
        if !enabledInteraction {return}
        createShadowTapped()
        createAnimation()
        setDelegate()
        addAnimationOnComponent()
        return
    }
    
    public var pressed: Void {
        if !enabledInteraction { return }
        if isPressed { return }
        _isPressed = true
        createShadowPressed()
        return
    }
    
    public var unpressed: Void {
        if !enabledInteraction { return }
        _isPressed = false
        removeShadow()
        return
    }
    

//  MARK: - SET PROPERTIES
    @discardableResult
    public func setColor(_ color: UIColor ) -> Self {
        self.colorInteraction = color
        return self
    }
    
    @discardableResult
    public func setColor(hexColor: String) -> Self {
        guard hexColor.isHexColor() else { return self }
        setColor(UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setShadowTapped(_ shadow: ShadowBuilder) -> Self {
        shadowTapped = shadow
        shadowTapped?.setID(identifier)
        return self
    }
    
    @discardableResult
    public func setShadowPressed(_ shadow: ShadowBuilder) -> Self {
        shadowPressed = shadow
        shadowPressed?.setID(identifier)
        return self
    }
    
    @discardableResult
    public func setEnabledInteraction(_ enabled: Bool) -> Self {
        self.enabledInteraction = enabled
        return self
    }
    
    @discardableResult
    public func setDurationAnimationTapped(_ duration: Double) -> Self {
        self.duration = duration
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    private func setDelegate() {
        animation.delegate = self
    }
    
    private func createShadowTapped() {
        if shadowTapped != nil { return }
        shadowTapped = createShadow()
    }
    
    private func createShadowPressed() {
        if shadowPressed != nil { return }
        shadowPressed = createShadow()
    }
    
    private func createShadow() -> ShadowBuilder? {
        guard let component else {return nil}
        let shadow = ShadowBuilder(component)
            .setColor(colorInteraction)
            .setOffset(width: 0, height: 0)
            .setOpacity(1)
            .setRadius(2)
            .setBringToFront()
            .setID(identifier)
            .applyLayer()
        return shadow
    }
    
    private func createAnimation() {
        animation = CABasicAnimation(keyPath: shadowOpacityProperty)
        animation.fromValue = 1.0
        animation.toValue = 1.0
        animation.duration = duration
        animation.isRemovedOnCompletion = true
    }
    
    private func addAnimationOnComponent() {
        if let layer = shadowTapped?.shadow {
            shadowLayer = layer
            shadowLayer.add(animation, forKey: identifier)
            shadowLayer.shadowOpacity = 1
        }
    }
    
    private func removeShadow() {
        component?.removeShadowByID(identifier)
    }
    
    private func removeShadowAnimation() {
        shadowLayer.removeAnimation(forKey: identifier)
    }
    
    private func freeMemory() {
        shadowTapped = nil
        shadowPressed = nil
        component = nil
        animation.delegate = nil
        animation = nil
    }
    
}

//  MARK: - EXTENSION CAAnimationDelegate
extension ButtonInteractionBuilder: CAAnimationDelegate {
    
    public func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: { [weak self] in
            guard let self else {return}
            shadowLayer.shadowOpacity = 0
            removeShadow()
            removeShadowAnimation()
            freeMemory()
        })
    }
    
}
