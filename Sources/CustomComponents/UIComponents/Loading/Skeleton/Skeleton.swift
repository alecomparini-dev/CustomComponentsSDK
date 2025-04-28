//  Created by Alessandro Comparini on 18/10/23.
//

import Foundation

@MainActor
public protocol Skeleton {
    typealias completion = () -> Void
    
    @discardableResult
    func setSpeedAnimation(_ speed: K.Skeleton.SpeedAnimation) -> Self
    
    @discardableResult
    func setColorSkeleton(hexColor: String?) -> Self
    
    @discardableResult
    func setCornerRadius(_ radius: CGFloat) -> Self
    
    @discardableResult
    func setTransition(_ duration: CGFloat) -> Self
    
    @discardableResult
    func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self
    
    func showSkeleton()
    
    func hideSkeleton()
    
}
