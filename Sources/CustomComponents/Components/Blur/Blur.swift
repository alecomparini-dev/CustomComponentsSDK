//  Created by Alessandro Comparini on 19/12/23.
//

import Foundation

public protocol Blur {
    associatedtype T
    
    var get: T  { get }
    
    @discardableResult
    func setOpacity(_ opacity: CGFloat) -> Self 
}
