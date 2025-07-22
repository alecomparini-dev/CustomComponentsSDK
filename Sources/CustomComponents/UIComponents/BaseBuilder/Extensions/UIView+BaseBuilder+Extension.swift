//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

@MainActor
extension UIView {
    
    @discardableResult
    public func setFrame(_ frame: CGRect?) -> Self {
        guard let frame else { return self }
        self.frame = frame
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(hexColor: String?) -> Self {
        guard let hexColor else { return self }
        self.backgroundColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(named: String?) -> Self {
        guard let named else { return self }
        self.backgroundColor = UIColor(named: named)
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(_ color: UIColor?) -> Self {
        guard let color else { return self }
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func setIsUserInteractionEnabled(_ interactionEnabled: Bool?) -> Self {
        guard let interactionEnabled else { return self }
        self.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    public func setOpacity(_ opacity: Float?) -> Self {
        guard let opacity else { return self }
        self.layer.opacity = opacity
        return self
    }
    
    @discardableResult
    public func setAlpha(_ alpha: CGFloat?) -> Self {
        guard let alpha else { return self }
        self.alpha = alpha
        return self
    }
   
    @discardableResult
    public func setHidden(_ hide: Bool?) -> Self {
        guard let hide else { return self }
        self.isHidden = hide
        return self
    }
    
    @discardableResult
    public func setHidden(_ hide: Bool, animated: Bool = false, _ duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) -> Self {
        if !animated {
            self.isHidden = hide
            self.setAlpha(1)
            completion?()
            return self
        }
        
        animatedHidden(hide, duration, completion)
        
        return self
    }
    
    
    
    
    private func animatedHidden(_ hide: Bool, _ duration: TimeInterval, _ completion: (() -> Void)?) {
        if hide { return invisible(duration, completion) }
        
        visible(duration, completion)
    }
    
    private func invisible(_ duration: TimeInterval, _ completion: (() -> Void)?) {
        
        DispatchQueue.main.async(execute: { [weak self] in
            guard let self else { return }
        
            if !self.isHidden {
                self.alpha = 1
            }
                        
            UIView.animate(withDuration: duration, delay: 0, animations: { [weak self] in
                self?.alpha = 0
            }){ [weak self] bool in
                if bool {
                    self?.isHidden = true
                    completion?()
                }
            }
        })
    }
    
    private func visible(_ duration: TimeInterval, _ completion: (() -> Void)?) {
        
        DispatchQueue.main.async(execute: { [weak self] in
            guard let self else {return}
            
            if self.isHidden {
                self.alpha = 0
                self.isHidden = false
            }
            
            UIView.animate(withDuration: duration, delay: 0, animations: { [weak self] in
                self?.alpha = 1
            }){ bool in
                if bool {
                    completion?()
                }
            }
        })
        
    }
}

