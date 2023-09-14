
//  Created by Alessandro Comparini on 13/09/23.
//

import Foundation

public protocol ButtonImage {
    var imageView: ImageViewBuilder { get }
    
    @discardableResult
    func setImageButton(_ image: ImageViewBuilder) -> Self
    
    @discardableResult
    func setImageColor(hexColor color: String?) -> Self
    
    @discardableResult
    func setImageColor(named color: String?) -> Self
    
    @discardableResult
    func setImageWeight(_ weight: K.Weight) -> Self
    
}
