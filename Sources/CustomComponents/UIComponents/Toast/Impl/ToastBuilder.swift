//  Created by Alessandro Comparini on 19/07/25.
//

import UIKit

@MainActor
open class ToastBuilder: ViewBuilder, Toast {
    private var hideTimer: Timer?

    private var _isShow = false
    
    private var disableAutoHide = false
    private var beganTouch: Double = 0
    private var position: ToastPosition = .bottom
    private var durationAutoHide: TimeInterval = 3.0
    private var animationShow: TimeInterval = 0.5
    private var animationHide: TimeInterval = 0.3
    private var onDismiss: (() -> Void)?
    
    public override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - GET PROPERTIES
    
    public func isShow() -> Bool { _isShow }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setDisableAutoHide() -> Self {
        self.disableAutoHide = true
        return self
    }
    
    @discardableResult
    public func setPosition(_ position: ToastPosition) -> Self {
        self.position = position
        return self
    }
    
    @discardableResult
    public func setDurationAutoHide(_ seconds: TimeInterval) -> Self {
        durationAutoHide = seconds
        return self
    }
    
    @discardableResult
    public func setAnimationShow(_ duration: TimeInterval) -> Self {
        animationShow = duration
        return self
    }
    
    @discardableResult
    public func setAnimationHide(_ duration: TimeInterval) -> Self {
        animationHide = duration
        return self
    }

    @discardableResult
    public func setOnDismiss(_ completion: @escaping () -> Void) -> Self {
        onDismiss = completion
        return self
    }
    
    
//  MARK: - ACTIONS
    
    public func show() {
        if _isShow { return }
        
        configPositionInitial()

        _isShow = true
        
        setHidden(false)
        
        if !disableAutoHide {
            hideTimer = Timer.scheduledTimer(timeInterval: durationAutoHide, target: self, selector: #selector(selectorHide), userInfo: nil , repeats: false)
        }
        
        let offset: CGFloat = getOffsetY()
        
        UIView.animate(withDuration: animationShow) { [weak self] in
            guard let self else { return }
            
            self.get.alpha = 1
            
            self.get.transform = CGAffineTransform(translationX: 0, y: offset)
        }
    }
    
    public func hide() {
        if !_isShow { return }
        
        _isShow = false
        
        hideTimer?.invalidate()
        
        let offset: CGFloat = getOffsetY()
        
        UIView.animate(withDuration: animationHide, animations: { [weak self] in
            guard let self else { return }

            self.get.transform = CGAffineTransform(translationX: 0, y: offset)
        }, completion: { [weak self] _ in
            guard let self else { return }
            
            self.onDismiss?()
        })
    }

    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addSwipeGesture()
        
        configInitial()
    }
    
    private func addSwipeGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        self.get.addGestureRecognizer(pan)
    }

    private func configInitial() {
        setAlpha(0)
        
        setHidden(true)
    }
    
    private func configPositionInitial() {
        let position = getOffsetY()
        
        self.get.transform = CGAffineTransform(translationX: 0, y: position)
    }
    
    private func getHeight() -> (toast: CGFloat, screen: CGFloat) {
        let height = self.get.bounds.height
        
        guard let win = self.get.window else { return (0,0)}
        
        let screenHeight = win.bounds.height
        
        return (height, screenHeight)
    }
    
    private func getOffsetY() -> CGFloat {
        let height = getHeight()
        
        if !isShow() {
            return (position == .top) ? -height.toast : height.screen + height.toast
        }
        
        return (position == .top) ? 0 : height.screen - height.toast
    }

    
//  MARK: - OBJCT PRIVATE AREA
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        
            case .began:
                beganTouch = translation.y
            
            case .changed:
                if position == .top {
                    if gestureDirection(translation.y) != .up { return }
                }
                    
                if position == .bottom {
                    if gestureDirection(translation.y) != .down { return }
                }
                
                hide()
            
            default:
                break
        }
    }
    
    @objc private func selectorHide() {
        hide()
    }
    
    private func gestureDirection(_ translationY: Double) -> GestureDirection {
        if (beganTouch - translationY) < 0 {
            return .down
        }
        
        return .up
    }
    
}


