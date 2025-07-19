//  Created by Alessandro Comparini on 19/07/25.
//

import Foundation

@MainActor
public protocol Toast {

    
//  MARK: - GET PROPERTIES
    
    func isShow() -> Bool


//  MARK: - SET PROPERTIES
    
    @discardableResult
    func setDuration(_ seconds: TimeInterval) -> Self
    
    @discardableResult
    func setPosition(_ position: ToastPosition) -> Self
        
    @discardableResult
    func setOnDismiss(_ completion: @escaping () -> Void) -> Self

    
//  MARK: - SHOW and HIDE
    
    func show()
    
    func hide()
}
