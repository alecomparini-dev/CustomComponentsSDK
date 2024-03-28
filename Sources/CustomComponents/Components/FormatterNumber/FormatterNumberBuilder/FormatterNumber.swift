//  Created by Alessandro Comparini on 27/10/23.
//

import Foundation


public protocol FormatterNumber {
    
    func formatter(double: Double) -> String?
    
    func getLocaleAvailable() -> [String]
    
    @discardableResult
    func setMinimumFractionDigits(_ minimum: Int) -> Self
    
    @discardableResult
    func setMaximumFractionDigits(_ max: Int) -> Self
    
    @discardableResult
    func setNumberStyle(_ style: NumberFormatter.Style) -> Self
    
    @discardableResult
    func setLocale(_ locale: String) -> Self
    
    @discardableResult
    func setCurrentLocale() -> Self
            
}

