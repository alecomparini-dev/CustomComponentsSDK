//  Created by Alessandro Comparini on 04/04/24.
//

import Foundation

public protocol DropdownMenu {
        
    var get: DropdownMenuView { get }
    
    @discardableResult
    func setSize(_ size: CGSize) -> Self
 
    
//  MARK: - GET PROPERTIES
    func isShow() -> Bool
    
//  MARK: - SHOW and HIDE
    func show()
    
    func hide()
}
