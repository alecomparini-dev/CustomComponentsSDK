
//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

public protocol TextFieldImage {
    var imageView: ImageViewBuilder { get }
    
    func setImage(_ image: ImageViewBuilder, _ position: K.Position.Horizontal, _ margin: CGFloat) -> Self
    
    func setImageSize(_ size: CGFloat, _ weight: K.Weight?) -> Self
    
    func setIsHideImage(_ hide: Bool) -> Self
    
    func setImageColor(hexColor: String) -> Self
    
}
