//  Created by Alessandro Comparini on 19/07/25.
//

import UIKit

@MainActor
open class ToastBuilder: ViewBuilder, Toast {
    private var hideTimer: Timer?

    private var _isShow = false
    private var position: ToastPosition = .bottom
    private var duration: TimeInterval = 3.0
    private var onDismiss: (() -> Void)?
    
    public override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - GET PROPERTIES
    
    public func isShow() -> Bool { _isShow }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setPosition(_ position: ToastPosition) -> Self {
        self.position = position
        return self
    }
    
    @discardableResult
    public func setDuration(_ seconds: TimeInterval) -> Self {
        duration = seconds
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
        
        hideTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(selectorHide), userInfo: nil , repeats: false)
        
        let offset: CGFloat = getOffsetY()
        
        UIView.animate(withDuration: 0.3) {
            self.get.alpha = 1
            self.get.frame.origin.y = offset
        }
            
    }
    
    public func hide() {
        if !_isShow { return }
        
        _isShow = false
        
        hideTimer?.invalidate()
        
        let targetY: CGFloat = getTargetY()
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            
            self?.get.frame.origin.y = targetY
            
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
        self.setAlpha(0.1)
    }
    
    private func getTargetY() -> CGFloat {
        let customView = self.get
        
        guard let window = customView.window else {
            return 0
        }
        
        let frameInWindow = customView.convert(customView.bounds, to: window)
        
        switch position {
        case .top:
            return -(frameInWindow.maxY)

        case .bottom:
            return window.bounds.height - 80
        }
    }

    private func configPositionInitial() {
        let position = getOffsetY()
        
        self.get.frame.origin.y = position
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
            case .changed:
                let offset = translation.y
            
                if position == .bottom && offset > 0 {
                    view.transform = CGAffineTransform(translationX: 0, y: offset)
                } else if position == .top && offset < 0 {
                    view.transform = CGAffineTransform(translationX: 0, y: offset)
                }
        
            case .ended, .cancelled:
                hide()

            
            default:
                break
        }
    }
    
    @objc private func selectorHide() {
//        hide()
    }
    
}
