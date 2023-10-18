//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

public enum DisplayTypes {
    case solid
    case gradient
    case solidAnimated
    case gradientAnimated
}

public protocol Skeleton {

    @discardableResult
    func setIsSkeletonable(_ flag: Bool) -> Self
    
    @discardableResult
    func setColorSkeleton(hexColor: String?) -> Self
    
    @discardableResult
    func setLastLineFillPercent(_ percent: Int) -> Self
    
    @discardableResult
    func setLinesCornerRadius(_ radius: Int) -> Self
    
    @discardableResult
    func setSkeletonLineSpacing(_ spacing: CGFloat) -> Self
    
    func showSkeleton(_ displayTypes: DisplayTypes)
    
    func hideSkeleton()
        
    
}
