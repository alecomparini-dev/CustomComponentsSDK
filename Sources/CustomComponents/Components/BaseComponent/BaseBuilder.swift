//  Created by Alessandro Comparini on 02/09/23.
//

import UIKit

open class BaseBuilder: NSObject {
    private(set) var border: BorderBuilder?
    
    private weak var _baseView: UIView?
    
    //  MARK: - GET Properties
        
    var baseView: UIView {
        get { self._baseView ?? UIView() }
        set { self._baseView = newValue }
    }
    
    public init(_ view: UIView) {
        self._baseView = view
        super.init()
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setTranslatesAutoresizingMaskIntoConstraints(_ flag: Bool) -> Self {
        baseView.translatesAutoresizingMaskIntoConstraints = flag
        return self
    }
    
    @discardableResult
    public func setFrame(_ frame: CGRect) -> Self {
        baseView.frame = frame
        return self
    }
    
    @discardableResult
    public func setBorder(_ build: (_ build: BorderBuilder) -> BorderBuilder) -> Self {
        self.border = build(BorderBuilder(baseView))
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(hexColor: String) -> Self {
        baseView.backgroundColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(color: String) -> Self {
        baseView.backgroundColor = UIColor(named: color)
        return self
    }
    
    
    @discardableResult
    func setIsUserInteractionEnabled(_ interactionEnabled: Bool) -> Self {
        baseView.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    public func setOpacity(_ opacity: Float) -> Self {
        baseView.layer.opacity = opacity
        return self
    }
    
    @discardableResult
    public func setAlpha(_ alpha: CGFloat) -> Self {
        baseView.alpha = alpha
        return self
    }
   
    @discardableResult
    public func setHidden(_ hide: Bool) -> Self {
        baseView.isHidden = hide
        return self
    }
    
    
}


//  MARK: - EXTENSION UIVIEW TO BASEBUILDER

extension UIView {
        
    @discardableResult
    public func setFrame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(hexColor: String) -> Self {
        self.backgroundColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(color: String) -> Self {
        self.backgroundColor = UIColor(named: color)
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func setIsUserInteractionEnabled(_ interactionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    public func setOpacity(_ opacity: Float) -> Self {
        self.layer.opacity = opacity
        return self
    }
    
    @discardableResult
    public func setAlpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
   
    @discardableResult
    public func setHidden(_ hide: Bool) -> Self {
        self.isHidden = hide
        return self
    }
    
}
