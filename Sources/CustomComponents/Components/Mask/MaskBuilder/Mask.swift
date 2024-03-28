//  Created by Alessandro Comparini on 16/10/23.
//

import Foundation

public protocol Mask {
    associatedtype T
    var get: T { get }
    
    func formatString(_ string: String) -> String
    func formatStringWithRange(range: NSRange, string: String) -> String
    func cleanText(_ text: String) -> String
    
    @discardableResult
    func setCustomMask(_ mask: String) -> Self
    
    @discardableResult
    func setDateMask(_ abbreviatedYear: Bool) -> Self
        
    @discardableResult
    func setDateUniversalMask() -> Self
    
    @discardableResult
    func setHourMask() -> Self

    @discardableResult
    func setCPFMask() -> Self
    
    @discardableResult
    func setCEPMask() -> Self
    
    @discardableResult
    func setCellPhoneNumberMask() -> Self
    
    
}
