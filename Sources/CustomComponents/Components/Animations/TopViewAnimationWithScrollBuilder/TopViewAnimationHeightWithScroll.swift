//  Created by Alessandro Comparini on 26/02/24.
//

import Foundation

public protocol TopViewAnimationHeightWithScroll {
    associatedtype T
    
    func setView(_ view: BaseBuilder) -> Self
    
    func setAnimation(_ heightChange: TopViewAnimationHeightWithScrollBuilder.HeightChange) -> Self

    func animation(_ scrollView: T)
}
