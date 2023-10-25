//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

extension UIView {
        
    @discardableResult
    public func setFrame(_ frame: CGRect?) -> Self {
        guard let frame else {return self}
        self.frame = frame
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(hexColor: String?) -> Self {
        guard let hexColor else {return self}
        self.backgroundColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(color: String?) -> Self {
        guard let color else {return self}
        self.backgroundColor = UIColor(named: color)
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(color: UIColor?) -> Self {
        guard let color else {return self}
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func setIsUserInteractionEnabled(_ interactionEnabled: Bool?) -> Self {
        guard let interactionEnabled else {return self}
        self.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    public func setOpacity(_ opacity: Float?) -> Self {
        guard let opacity else {return self}
        self.layer.opacity = opacity
        return self
    }
    
    @discardableResult
    public func setAlpha(_ alpha: CGFloat?) -> Self {
        guard let alpha else {return self}
        self.alpha = alpha
        return self
    }
   
    @discardableResult
    public func setHidden(_ hide: Bool?) -> Self {
        guard let hide else {return self}
        self.isHidden = hide
        return self
    }
    
}
