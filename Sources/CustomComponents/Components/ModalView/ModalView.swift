
//  Created by Alessandro Comparini on 23/05/24.
//

import Foundation

public protocol ModalView {
    associatedtype S
    
    var get: ViewBuilder { get }


//  MARK: - GET PROPERTIES
    func isShow() -> Bool
    

//  MARK: - SET PROPERTIES
    @discardableResult
    func setCloseWhenTappedOut() -> Self
    
    @discardableResult
    func setOverlay(style: S, opacity: CGFloat) -> Self
    
    @discardableResult
    func setAnimation(_ duration: TimeInterval) -> Self

    
//  MARK: - SHOW and HIDE
    func show()
    
    func hide()
    
}
