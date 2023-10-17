//  Created by Alessandro Comparini on 17/10/23.
//

import Foundation

public protocol Loading {
    associatedtype T
    var get: T { get }
    
    @discardableResult
    func setColor(hexColor: String?) -> Self
    
    @discardableResult
    func setStyle(_ style: K.ActivityIndicator.Style) -> Self
    
    @discardableResult
    func setHidesWhenStopped(_ hide: Bool) -> Self
    
    func setStartAnimating()
    
    func setStopAnimating()
    
}
