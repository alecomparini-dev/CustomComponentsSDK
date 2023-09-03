//  Created by Alessandro Comparini on 02/09/23.
//

import UIKit

open class BorderBuilder {

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
    public func setColor(_ color: UIColor) -> Self {
        component.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ radius: CGFloat) -> Self {
        self.removeBorderStyleOfTextField()
        component.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    public func setWhichCornersWillBeRounded(_ cornes: [K.Corner]) -> Self {
        component?.layer.maskedCorners = selectCorners(cornes)
        return self
    }
    
    
//  MARK: -      Area
    
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
