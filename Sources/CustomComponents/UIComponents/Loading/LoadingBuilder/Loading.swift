//  Created by Alessandro Comparini on 17/10/23.
//

import Foundation

@MainActor
public protocol Loading {
    associatedtype T
    var get: T { get }
    
    @discardableResult
    func setColor(hexColor: String?) -> Self
    
    @discardableResult
    func setStyle(_ style: K.ActivityIndicator.Style) -> Self
    
    @discardableResult
    func setHideWhenStopped(_ hide: Bool) -> Self
    
    @discardableResult
    func setStartAnimating() -> Self
    
    @discardableResult
    func setStopAnimating() -> Self
    
}
