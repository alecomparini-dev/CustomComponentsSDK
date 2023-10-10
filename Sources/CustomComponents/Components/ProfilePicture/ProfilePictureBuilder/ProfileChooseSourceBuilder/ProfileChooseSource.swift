//  Created by Alessandro Comparini on 10/10/23.
//

import Foundation

protocol ProfileChooseSource {
    typealias completion = () -> Void
    
    @discardableResult
    func setTitle(title: String) -> Self
    
    @discardableResult
    func setOpenCamera(completion: completion?) -> Self
    
    @discardableResult
    func setOpenGallery(completion: completion?) -> Self
    
    
}
