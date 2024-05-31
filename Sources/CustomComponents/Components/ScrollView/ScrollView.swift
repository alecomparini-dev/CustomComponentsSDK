//  Created by Alessandro Comparini on 14/05/24.
//

import Foundation

@MainActor
public protocol ScrollView {
    associatedtype S
    
    var get: S { get }
    
    @discardableResult
    func setShowsVerticalScrollIndicator(_ flag: Bool) -> Self
    
    @discardableResult
    func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self
    
}
