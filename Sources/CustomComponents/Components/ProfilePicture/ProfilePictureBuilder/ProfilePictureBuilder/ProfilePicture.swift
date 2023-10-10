//  Created by Alessandro Comparini on 09/10/23.
//

import Foundation

public protocol ProfilePicture: AnyObject {
    
    @discardableResult
    func setPlaceHolderImage(_ image: ImageViewBuilder) -> Self
    
    @discardableResult
    func setCornerRadius(_ radius: CGFloat) -> Self
    
    @discardableResult
    func setSizePlaceHolderImage(_ size: CGFloat) -> Self
    
    @discardableResult
    func setTintColor(_ hexColor: String) -> Self
    
}
