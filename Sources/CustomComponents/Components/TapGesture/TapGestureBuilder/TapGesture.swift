//  Created by Alessandro Comparini on 12/09/23.
//

import Foundation

public protocol TapGesture {
    
    typealias touchGestureAlias = (_ tapGesture: TapGestureBuilder) -> Void


//  MARK: - GET PROPERTIES
    func getTouchPosition(_ touchPositionRelative: TapGestureBuilder.GestureRelativeTo) -> CGPoint
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    func setNumberOfTapsRequired(_ numberOfTaps: Int) -> Self
    
    @discardableResult
    func setNumberOfTouchesRequired(_ numberOfTouches: Int) -> Self
    
    @discardableResult
    func setCancelsTouchesInView(_ cancel: Bool ) -> Self
    
    @discardableResult
    func setTap(_ closure: @escaping touchGestureAlias) -> Self
    
    @discardableResult
    func setTouchMoved(_ closure: @escaping touchGestureAlias) -> Self
    
    @discardableResult
    func setTouchCancelled(_ closure: @escaping touchGestureAlias) -> Self
    
    @discardableResult
    func setIsEnabled(_ enabled: Bool ) -> Self
    
    func removeTapGesture()
}
