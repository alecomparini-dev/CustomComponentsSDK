//  Created by Alessandro Comparini on 16/10/23.
//

import Foundation

public protocol Mask {
    associatedtype T
    var get: T { get }
    
    func getFormatString(_ string: String) -> String
    
    @discardableResult
    func setCustomMask(_ mask: String) -> Self
    
    @discardableResult
    func setDateMask(_ abbreviatedYear: Bool) -> Self

    @discardableResult
    func setCPFMask() -> Self
    
    @discardableResult
    func setCEPMask() -> Self
    
    @discardableResult
    func setCellPhoneNumberMask() -> Self
    
    
}
