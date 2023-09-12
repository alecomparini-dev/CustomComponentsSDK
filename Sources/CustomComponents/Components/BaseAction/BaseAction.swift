
//  Created by Alessandro Comparini on 12/09/23.
//

import Foundation

public protocol BaseAction {
    typealias touchBaseActionAlias = (_ component: ViewBuilder, _ tapGesture: TapGestureBuilder?) -> Void
    
    @discardableResult
    func setTouch(_ closure: @escaping touchBaseActionAlias, _ cancelsTouchesInView: Bool) -> Self
    
}
