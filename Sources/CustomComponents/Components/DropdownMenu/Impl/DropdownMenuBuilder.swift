//  Created by Alessandro Comparini on 04/04/24.
//

import Foundation

open class DropdownMenuBuilder: BaseBuilder, DropdownMenu {
    
    public var get: DropdownMenuView { dropdownMenu }
    
    private var zPosition: CGFloat = 10000
    private var isVisible = false
    
    
//  MARK: - INITIALIZERS
    
    private var dropdownMenu: DropdownMenuView
        
    public init(size: CGSize) {
        dropdownMenu = DropdownMenuView(frame: CGRect(origin: .zero, size: size))
        super.init(dropdownMenu.get)
    }

    
//  MARK: - GET PROPERTIES
    public func isShow() -> Bool { isVisible }

    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setSize(_ size: CGSize) -> Self {
        dropdownMenu.get.frame.size = size
        dropdownMenu.get.layoutIfNeeded()
        return self
    }
    
    

//  MARK: - SHOW and HIDE
    
    public func show() {
        isVisible = true
        dropdownMenu.setHidden(false)
    }
    
    public func hide() {
        isVisible = false
        dropdownMenu.setHidden(true)
    }

    
}
