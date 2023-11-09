//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation


public protocol Skeleton {
    typealias completion = () -> Void
    
    @discardableResult
    func setSpeedAnimation(_ speed: K.Skeleton.SpeedAnimation) -> Self
    
    @discardableResult
    func setColorSkeleton(hexColor: String?) -> Self
    
    @discardableResult
    func apply() -> Self
    
    func hideSkeleton(_ completion: completion?)
    
}
