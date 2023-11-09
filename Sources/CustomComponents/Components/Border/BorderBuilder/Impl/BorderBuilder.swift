//  Created by Alessandro Comparini on 02/09/23.
//

import UIKit

open class BorderBuilder: Border {
    
    private weak var component: UIView!
    
    
//  MARK: - Initializers
    public init(_ component: UIView) {
        self.component = component
    }
    

//  MARK: - SET Properties
    @discardableResult
    public func setWidth(_ width: CGFloat) -> Self {
        component.layer.borderWidth = width
        return self
    }
    
    @discardableResult
    public func setColor(color: UIColor?) -> Self {
        guard let color else {return self}
        component.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    public func setColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setColor(color: UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setColor(color: namedColor)
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ radius: CGFloat) -> Self {
        self.removeBorderStyleOfTextField()
//        component?.layer.masksToBounds = true
        component.clipsToBounds = true
//        component.layer.cornerRadius = radius
        
        var corner: CAShapeLayer = CAShapeLayer()
        corner.cornerRadius = radius
        component.layer.insertSublayer(corner, at: 0)
        DispatchQueue.main.async { [weak self] in
            guard let self, let component else {return}
            
            corner.frame = component.bounds
            corner.path = component.replicateFormat(width: component.frame.width,
                                                     height: component.frame.height,
                                                     cornerRadius: radius
            ).cgPath
            
        }
        return self
    }
    
    @discardableResult
    public func setWhichCornersWillBeRounded(_ cornes: [K.Corner]) -> Self {
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
