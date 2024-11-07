//  Created by Alessandro Comparini on 07/11/24.
//

import Foundation

@MainActor
public protocol RefreshControl: AnyObject {
    associatedtype T
    
    var get: T { get }
    
    @discardableResult
    func setTextAttributed(_ attributedTitle: String) -> Self
            
    @discardableResult
    func setTintColor(hexColor: String?) -> Self

    func beginRefreshing()
    
    func endRefreshing()
    
    func isRefresing() -> Bool

    
//  MARK: - SET ACTION
    
    @discardableResult
    func setActions(action: (_ build: RefreshControlActionsBuilder) -> RefreshControlActionsBuilder) -> Self
    
}
