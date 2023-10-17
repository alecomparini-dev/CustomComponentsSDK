//  Created by Alessandro Comparini on 12/09/23.
//

import Foundation

public protocol Switch {
    associatedtype T
    var get: T { get }
    
    @discardableResult
    func setIsOn(_ flag: Bool) -> Self
    
    @discardableResult
    func setOnTintColor(hexColor: String?) -> Self
    
    @discardableResult
    func setOnTintColor(named color: String?) -> Self
    
    @discardableResult
    func setThumbTintColor(hexColor color: String?) -> Self
    
    @discardableResult
    func setThumbTintColor(named color: String?) -> Self
    
    
}
