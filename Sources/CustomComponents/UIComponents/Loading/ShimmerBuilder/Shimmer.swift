//  Created by Alessandro Comparini on 20/10/23.
//

import Foundation

@MainActor
public protocol Shimmer {
    
    @discardableResult
    func startShimmer() -> Self

    @discardableResult
    func stopShimmer() -> Self

}
