//  Created by Alessandro Comparini on 10/04/24.
//

import Foundation

public protocol BoxShadowInset {
    associatedtype UIColor
    
    @discardableResult
    func setShadowOffset(top: CGFloat?, left: CGFloat?, right: CGFloat?, bottom: CGFloat?) -> Self

    @discardableResult
    func setLightShadow(_ color: UIColor, opacity: Float) -> Self
    
    @discardableResult
    func setDarkShadow(_ color: UIColor, opacity: Float) -> Self
    
}
