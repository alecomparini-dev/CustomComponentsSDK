//  Created by Alessandro Comparini on 23/04/24.
//

import Foundation

public protocol SwitchButton {
    
    var get: ViewBuilder { get }
    
    func setViewLeft(_ view: ViewBuilder) -> Self
    
    func setViewRight(_ view: ViewBuilder) -> Self
    
}
