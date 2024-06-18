
//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

@MainActor
public protocol TextFieldImage {
    var imageViewLeft: ImageViewBuilder? { get }
    
    var imageViewRight: ImageViewBuilder? { get }
    
    func setImage(_ image: ImageViewBuilder, _ position: K.Position.Horizontal, _ margin: CGFloat) -> Self
    
    func setImageSize(_ size: CGFloat?, _ weight: K.Weight?) -> Self
    
    func setIsHideImage(_ hide: Bool, position: K.Position.Horizontal?) -> Self
    
    func setImageColor(hexColor: String?, position: K.Position.Horizontal?) -> Self
    
    @discardableResult
    func setActions(textFieldImage action: (_ build: TextFieldImageActionBuilder) -> TextFieldImageActionBuilder) -> Self 
}
