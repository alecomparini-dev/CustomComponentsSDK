//  Created by Alessandro Comparini on 10/10/23.
//

import Foundation


public protocol ProfileChooseSource {
    typealias completion = (_ imageData: Data?) -> Void
    
    @discardableResult
    func setTitle(title: String) -> Self
    
    @discardableResult
    func setOpenCamera(_ title: String?, completion: completion?) -> Self
    
    @discardableResult
    func setOpenGallery(_ title: String?,completion: completion?) -> Self
    
    
}
