//  Created by Alessandro Comparini on 10/06/24.
//

import Foundation

public struct NumberFormatterBuilder {
    
    private let constantDecimal = 0.01
    private var locale = Locale.current
    
    
//  MARK: - INIALIZERS
    
    public var get: NumberFormatter { number }
    
    private let number: NumberFormatter
    
    public init() {
        number = NumberFormatter()
        number.locale = Locale.current
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
    
    
//  MARK: - PUBLIC AREA
    
    public func parseDouble(value: String) -> Double? {
        let formatter = copyFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: value)?.doubleValue
    }
    
    public func parseString(value: Double) -> String? {
        let formatter = copyFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value))
    }

    public func parseCurrency(value: Double) -> String? {
        let formatter = copyFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: value))
    }
    
    public func parseCurrency(value: String) -> String? {
        guard let vlr = parseDouble(value: value) else { return nil}
        let formatter = copyFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: vlr))
    }

    public func removeDecimalSeparator(value: String) -> String {
        let formatter = copyFormatter()
        let separator = formatter.decimalSeparator ?? "."
        let components = value.components(separatedBy: separator)
        let joinedString = components.joined()
        let groupingSeparator = formatter.groupingSeparator ?? ","
        let finalString = joinedString.replacingOccurrences(of: groupingSeparator, with: "")
        return finalString.replacingOccurrences(of: "-", with: "")
    }

    public func maskDecimal(value: String) -> String? {
        let valueStr = removeDecimalSeparator(value: value)
        guard var value = parseDouble(value: valueStr) else { return nil}
        value = value * constantDecimal
        let formatter = copyFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value))
    }
    
    
    
//  MARK: - PRIVATE AREA
    private func copyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = number.locale
        formatter.usesGroupingSeparator = number.usesGroupingSeparator
        formatter.minimumFractionDigits = number.minimumFractionDigits
        formatter.maximumFractionDigits = number.maximumFractionDigits
        return formatter
    }


}

