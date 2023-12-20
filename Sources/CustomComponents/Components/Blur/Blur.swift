//  Created by Alessandro Comparini on 19/12/23.
//

import Foundation

public protocol Blur {
    var get: ViewBuilder  { get }
    
    @discardableResult
    func setOpacity(_ opacity: CGFloat) -> Self 
}
