//  Created by Alessandro Comparini on 10/10/23.
//

import Foundation

@MainActor
public protocol ProfileChooseSource {
    typealias completion = (_ imageViewBuilder: ImageViewBuilder?) -> Void
    
    @discardableResult
    func setTitle(_ title: String) -> Self
    
    @discardableResult
    func setOpenCamera(_ title: String?, completion: completion?) -> Self
    
    @discardableResult
    func setOpenGallery(_ title: String?, completion: completion?) -> Self
    
    
}
