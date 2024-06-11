//  Created by Alessandro Comparini on 10/06/24.
//

import Foundation

public struct NumberFormatterBuilder {
    
    private var locale = Locale.current
    
    
//  MARK: - INIALIZERS
    
    public var get: NumberFormatter { number }
    
    private let number: NumberFormatter
    
    init() {
        self.number = NumberFormatter()
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setLocale(_ identifier: String) -> Self {
        number.locale = Locale(identifier: identifier)
        return self
    }
    
    @discardableResult
    public func setNumberStyle(_ style: NumberFormatter.Style ) -> Self {
        number.numberStyle = style
        return self
    }
    
    @discardableResult
    public func setMinimumFractionDigits(_ digits: Int) -> Self {
        number.minimumFractionDigits = digits
        return self
    }
    
    @discardableResult
    public func setMaximumFractionDigits(_ digits: Int) -> Self {
        number.maximumFractionDigits = digits
        return self
    }
    
    @discardableResult
    public func setUsesGroupingSeparator(_ flag: Bool) -> Self {
        number.usesGroupingSeparator = flag
        return self
    }
    
}
