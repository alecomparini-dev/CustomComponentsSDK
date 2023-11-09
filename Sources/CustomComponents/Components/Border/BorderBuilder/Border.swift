//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

public protocol Border {
    
    @discardableResult
    func setWidth(_ width: CGFloat) -> Self
    
    @discardableResult
    func setColor(hexColor color: String?) -> Self
    
    @discardableResult
    func setColor(named color: String?) -> Self
    
    @discardableResult
    func setCornerRadius(_ radius: CGFloat) -> Self
    
    @discardableResult
    func setWhichCornersWillBeRounded(_ cornes: [K.Corner]) -> Self
    
}
