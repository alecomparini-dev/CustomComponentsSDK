//  Created by Alessandro Comparini on 23/05/24.
//

import UIKit

open class ModalViewBuilder: BaseBuilder , ModalView {
    public typealias S = UIBlurEffect.Style
    
    
    private var isVisible = false
    private var isApplyOnce = false
    private var autoCloseEnabled = false

    private var animationDuration: TimeInterval = 0
    private var zPosition: CGFloat = 10000

    private var excludeComponents = [BaseBuilder]()
    private var overlay: BlurBuilder?
    private var tap: TapGestureBuilder?
    

//  MARK: - INITIALIZERS
    
    public var get: ViewBuilder {modal}
    private let modal: ViewBuilder
    
    public init() {
        self.modal = ViewBuilder().setHidden(true)
        super.init(modal.get)
    }
    
    
//  MARK: - GET PROPERTIES
    
    public func isShow() -> Bool { isVisible }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setCloseWhenTappedOut() -> Self {
        autoCloseEnabled = true
        return self
    }
    
    @discardableResult
    public func setOverlay(style: UIBlurEffect.Style, opacity: CGFloat = 1) -> Self {
        overlay = BlurBuilder(style: style)
            .setOpacity(opacity)
        return self
    }
    
    @discardableResult
    public func setIgnoreOverlay(for components: [BaseBuilder]) -> Self {
        excludeComponents = components
        return self
    }
    
    @discardableResult
    public func setAnimation(_ duration: TimeInterval = 0.5) -> Self {
        animationDuration = duration
        return self
    }

    
//  MARK: - ACTIONS
    public func show() {
        if isVisible {return}
        isVisible = true
        applyOnce()
        showAnimation()
    }
    
    public func hide() {
        if !isVisible {return}
        isVisible = false
//        events?.willDisappearDropdowMenu()
        hideAnimation { [weak self] in
            guard let self else {return }
            modal.setHidden(true)
            overlay?.setHidden(true)
//            events?.didDisappearDropdowMenu()
        }
    }
    
    
//  MARK: - PRIVATE AREA
    private func applyOnce() {
        if isApplyOnce {return}
        
        configOverlay()
        
        configHierarchyVisualization()
        
        configAutoClose()
        
        isApplyOnce = true
    }
    
    private func getSuperview() -> UIView? {
        guard let superview = modal.get.superview else {return nil}
        return superview
    }
    
    private func configOverlay() {
        guard let superview = getSuperview() else {return}
        
        self.overlay?
            .setAutoLayout { build in
                build
                    .pin.equalToSuperview()
            }

        overlay?.add(insideTo: superview)
        overlay?.applyAutoLayout()
    }
    
    private func configHierarchyVisualization() {
        overlay?.get.layer.zPosition = zPosition
        modal.get.layer.zPosition = zPosition + 1
        excludeComponents.forEach { comp in
            comp.baseView.layer.zPosition = self.zPosition + 1
        }
        bringToFront()
    }
    
    private func bringToFront() {
        guard let superview = getSuperview() else {return}
        superview.bringSubviewToFront(modal.get)
        excludeComponents.forEach { comp in
            superview.bringSubviewToFront(comp.baseView)
        }
    }
    
    private func configAutoClose() {
        guard let overlay = overlay else {return}
        if autoCloseEnabled {
            _ = TapGestureBuilder(overlay.get)
                .setCancelsTouchesInView(true)
                .setTap({ [weak self] tapGesture in
                    self?.verifyTappedOutMenu(tapGesture)
                })
        }
    }
    
    private func verifyTappedOutMenu(_ tap: TapGestureBuilder?) {
        if isShow() {
            if isTappedOut(tap) { hide() }
        }
    }
    
    private func isTappedOut(_ tap: TapGestureBuilder?) -> Bool {
        guard let tap else {return false}
        let touchPoint = tap.getTouchPosition(.superview)
        if isTappedOut(touchPoint) && isTappedOutExcludeComponents(touchPoint) { return true }
        return false
    }
    
    private func isTappedOut(_ touchPoint: CGPoint) -> Bool {
        if modal.get.frame.contains(touchPoint) { return false }
        return true
    }
    
    private func isTappedOutExcludeComponents(_ touchPoint: CGPoint) -> Bool {
        var isTappedOut = true
        excludeComponents.forEach { comp in
            if comp.baseView.frame.contains(touchPoint) {
                isTappedOut = false
                return
            }
        }
        return isTappedOut
    }
    

//  MARK: - ANIMATIONS AREA
    private func showAnimation(_ completion: (() -> Void)? = nil) {
        configStartAnimation()
        modal.setHidden(false, animated: true, animationDuration)
        overlay?.setHidden(false, animated: true, animationDuration)
    }
    
    private func configStartAnimation() {
        modal.setAlpha(0)
        overlay?.setAlpha(0)
        modal.setHidden(false)
        overlay?.setHidden(false)
    }
    
    private func hideAnimation(_ completion: (() -> Void)? = nil) {
        modal.setHidden(true, animated: true, animationDuration)
        overlay?.setHidden(true, animated: true, animationDuration)
    }
    
    
}
