//  Created by Alessandro Comparini on 26/02/24.
//

import Foundation

public protocol TopViewAnimationHeightWithScroll {
    
    var get: ViewBuilder { get }
    
    func setView(_ viewBuilder: ViewBuilder) -> Self
    
    func setAnimation(_ heightChange: TopViewAnimationHeightWithScrollBuilder.HeightChange) -> Self

    func start(height: (ini: CGFloat, end: CGFloat))
}
