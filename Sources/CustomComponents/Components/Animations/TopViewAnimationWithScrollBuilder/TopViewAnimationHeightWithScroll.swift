//  Created by Alessandro Comparini on 26/02/24.
//

import Foundation

public protocol TopViewAnimationHeightWithScroll {
    associatedtype T
    
    func setView(_ view: BaseBuilder) -> Self
    
    func setInitialOffsetScroll(_ scrollView: T) -> Self
    
    func setAnimationDirection(_ direction: TopViewAnimationHeightWithScrollBuilder.Direction) -> Self

    func animation(_ scrollView: T)
}
