//  Created by Alessandro Comparini on 26/09/23.
//

import Foundation

public protocol TabBar {
    associatedtype T
    var get: T { get }
    
    func setItem(items: TabBarItems) -> Self
    
    @discardableResult
    func setTranslucent( _ flag: Bool) -> Self
    
    @discardableResult
    func setTintColor(hexColor color: String?) -> Self

    @discardableResult
    func setUnselectedItemTintColor(hexColor color: String?) -> Self
    
}
