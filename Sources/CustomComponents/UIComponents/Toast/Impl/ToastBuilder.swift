//  Created by Alessandro Comparini on 19/07/25.
//

import UIKit

@MainActor
open class ToastBuilder: ViewBuilder, Toast {
    
    private var hideTimer: Timer?

    private var position: ToastPosition = .bottom
    private var duration: TimeInterval = 3.0
    private var onDismiss: (() -> Void)?
    
    public override init() {
        super.init()
        configure()
    }
    
    
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
        hideTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(selectorHide), userInfo: nil , repeats: false)
        
        let offset: CGFloat = getTargetY()
        
        self.get.transform = CGAffineTransform(translationX: 0, y: -offset)
        
        self.get.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.get.alpha = 1
            self.get.transform = .identity
        }
    }
    
    public func hide() {
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
        self.setAlpha(0)
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
            let screenHeight = window.bounds.height
            return screenHeight - frameInWindow.minY
        }
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
    
    @objc private func selectorHide() { hide() }
    
}
