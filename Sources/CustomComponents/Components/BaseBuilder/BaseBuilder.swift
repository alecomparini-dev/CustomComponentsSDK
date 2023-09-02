//  Created by Alessandro Comparini on 02/09/23.
//

import UIKit


open class BaseBuilder: NSObject {
    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    private let view: UIView
    
    public init(_ view: UIView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @discardableResult
    public func setFrame(_ frame: CGRect) -> Self {
        view.frame = frame
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(hexColor: String) -> Self {
        view.backgroundColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(color: String) -> Self {
        view.backgroundColor = UIColor(named: color)
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(color: UIColor) -> Self {
        view.backgroundColor = color
        return self
    }
    
    @discardableResult
    func setIsUserInteractionEnabled(_ interactionEnabled: Bool) -> Self {
        view.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    public func setOpacity(_ opacity: Float) -> Self {
        view.layer.opacity = opacity
        return self
    }
    
    @discardableResult
    public func setAlpha(_ alpha: CGFloat) -> Self {
        view.alpha = alpha
        return self
    }
   
    @discardableResult
    public func setHidden(_ hide: Bool) -> Self {
        view.isHidden = hide
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
