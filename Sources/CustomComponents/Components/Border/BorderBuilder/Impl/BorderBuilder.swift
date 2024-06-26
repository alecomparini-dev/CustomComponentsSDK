//  Created by Alessandro Comparini on 02/09/23.
//

import UIKit

@MainActor
open class BorderBuilder: Border {
    private weak var component: UIView!
    
    
//  MARK: - Initializers
    public init(_ component: UIView) {
        self.component = component
    }
    

//  MARK: - SET PROPERTIES
    @discardableResult
    public func setWidth(_ width: CGFloat) -> Self {
        component.layer.borderWidth = width
        return self
    }
    
    @discardableResult
    public func setColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        component.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    public func setColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setColor(namedColor)
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ radius: CGFloat) -> Self {
        removeBorderStyleOfTextField()
        setClipsToBounds(true)
        component.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    public func setClipsToBounds(_ flag: Bool) -> Self {
        component.clipsToBounds = flag
        return self
    }
    
    @discardableResult
    public func setMasksToBounds(_ flag: Bool) -> Self {
        component.layer.masksToBounds = flag
        return self
    }
     
    @discardableResult
    public func setRoundedCorners(_ cornes: [K.Corner]) -> Self {
        component?.layer.maskedCorners = selectCorners(cornes)
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func selectCorners(_ cornes: [K.Corner]) -> CACornerMask {
        var selection: CACornerMask = []
        cornes.forEach { corner in
            switch corner {
            case .leftTop:
                selection.insert(CACornerMask.layerMinXMinYCorner)
            
            case .rightTop:
                selection.insert(CACornerMask.layerMaxXMinYCorner)
            
            case .leftBottom:
                selection.insert(CACornerMask.layerMinXMaxYCorner)
            
            case .rightBottom:
                selection.insert(CACornerMask.layerMaxXMaxYCorner)
            
            case .top:
                selection.insert(CACornerMask.layerMinXMinYCorner)
                selection.insert(CACornerMask.layerMaxXMinYCorner)
            
            case .bottom:
                selection.insert(CACornerMask.layerMinXMaxYCorner)
                selection.insert(CACornerMask.layerMaxXMaxYCorner)
            
            case .left:
                selection.insert(CACornerMask.layerMinXMinYCorner)
                selection.insert(CACornerMask.layerMinXMaxYCorner)
            
            case .right:
                selection.insert(CACornerMask.layerMaxXMinYCorner)
                selection.insert(CACornerMask.layerMaxXMaxYCorner)
            
            case .diagonalUp:
                selection.insert(CACornerMask.layerMinXMaxYCorner)
                selection.insert(CACornerMask.layerMaxXMinYCorner)
            
            case .diagonalDown:
                selection.insert(CACornerMask.layerMinXMinYCorner)
                selection.insert(CACornerMask.layerMaxXMaxYCorner)
            }
        }
        return selection
    }
    
    private func removeBorderStyleOfTextField() {
        guard let component else {return}
        if component.isKind(of: UITextField.self) {
            (component as! UITextField).borderStyle = UITextField.BorderStyle.none
        }
    }
    
}
