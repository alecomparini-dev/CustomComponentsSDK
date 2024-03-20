//  Created by Alessandro Comparini on 08/11/23.
//

import Foundation


public protocol Shadow {
    associatedtype T

    func getShadowById(_ id: String) -> T?
    
    @discardableResult
    func setColor(hexColor: String?) -> Self
    
    @discardableResult
    func setOffset(width: Int, height: Int) -> Self
    
    @discardableResult
    func setOffset(_ offSet: CGSize) -> Self
    
    @discardableResult
    func setOpacity(_ opacity: Float) -> Self
    
    @discardableResult
    func setRadius(_ radius: CGFloat) -> Self
    
    @discardableResult
    func setCornerRadius(_ cornerRadius: CGFloat) -> Self
    
    @discardableResult
    func setBringToFront() -> Self
    
    @discardableResult
    func setShadowHeight(_ height: CGFloat) -> Self
    
    @discardableResult
    func setShadowWidth(_ width: CGFloat) -> Self
    
    @discardableResult
    func setID(_ id: String) -> Self
            
    func apply()
    func applyLayer()

}
