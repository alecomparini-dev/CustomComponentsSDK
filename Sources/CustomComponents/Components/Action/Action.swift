
//  Created by Alessandro Comparini on 12/09/23.
//

import Foundation

@MainActor
public protocol Action {
    associatedtype T
    
    typealias touchBaseActionAlias = (_ tapGesture: TapGestureBuilder?) -> Void
    
    @discardableResult
    func setTap(_ closure: @escaping touchBaseActionAlias, _ cancelsTouchesInView: Bool) -> Self
    
}
