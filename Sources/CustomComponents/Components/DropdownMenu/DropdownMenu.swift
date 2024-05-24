//  Created by Alessandro Comparini on 04/04/24.
//

import Foundation

public protocol DropdownMenu {
    associatedtype S
    
    var get: ViewBuilder { get }
    
    var dropdowMenuList: ListBuilder? { get }

//  MARK: - SET PROPERTIES 

    @discardableResult
    func setCloseMenuWhenTappedOut(excludeComponents: [BaseBuilder]) -> Self
    
    @discardableResult
    func setOverlay(style: S, opacity: CGFloat) -> Self
    
    @discardableResult
    func setAnimation(_ duration: TimeInterval) -> Self
    
    
//  MARK: - CONFIG LIST
    
    @discardableResult
    func setConfigList(style: K.List.Style, _ build: (_ build: ListBuilder) -> ListBuilder) -> Self
    
    
//  MARK: - POPULATE DATA
    
    @discardableResult
    func setPopulateItems(_ build: (_ build: DropdownMenuItemsBuilder) -> DropdownMenuItemsBuilder) -> Self

    
//  MARK: - CONFIG FOOTER VIEW
    
    @discardableResult
    func setConfigFooterView(height: CGFloat, _ view: ViewBuilder) -> Self
    
    
//  MARK: - GET PROPERTIES
    
    func isShow() -> Bool
    
    
//  MARK: - SHOW and HIDE
    
    func show()
    
    func hide()
}
