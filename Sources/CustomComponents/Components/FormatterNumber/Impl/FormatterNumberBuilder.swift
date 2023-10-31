//  Created by Alessandro Comparini on 27/10/23.
//

import UIKit


open class FormatterNumberBuilder: FormatterNumber {
    
    private let numberFormatter: NumberFormatter
    
    public init() {
        self.numberFormatter = NumberFormatter()
    }
    
    public func formatter(double: Double) -> String? {
        return numberFormatter.string(from: NSNumber(value: double))
    }
    
    public func getLocaleAvailable() -> [String] {
        return Locale.availableIdentifiers
    }
    
    @discardableResult
    public func setMinimumFractionDigits(_ min: Int) -> Self {
        numberFormatter.minimumFractionDigits = min
        return self
    }
    
    @discardableResult
    public func setMaximumFractionDigits(_ max: Int) -> Self {
        numberFormatter.maximumFractionDigits = max
        return self
    }
    
    @discardableResult
    public func setNumberStyle(_ style: NumberFormatter.Style) -> Self {
        numberFormatter.numberStyle = style
        return self
    }
    
    @discardableResult
    public func setLocale(_ locale: String) -> Self {
        numberFormatter.locale = Locale(identifier: locale)
        return self
    }
    
    @discardableResult
    public func setCurrentLocale() -> Self {
        numberFormatter.locale = Locale.current
        return self
    }
    
    
}
