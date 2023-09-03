//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

public protocol TextField {
    associatedtype T
    
    var get: T { get }
    
//    @discardableResult
//    func setPlaceHolder(_ placeholder: String) -> Self {
//        _textField.attributedPlaceholder = NSAttributedString (
//            string: placeholder,
//            attributes: self.attributesPlaceholder)
//        return self
//    }
//
//    @discardableResult
//    func setPlaceHolderColor(_ placeHolderColor: UIColor) -> Self {
//        self.attributesPlaceholder.updateValue(placeHolderColor, forKey: .foregroundColor)
//        _textField.attributedPlaceholder = NSAttributedString (
//            string: _textField.placeholder ?? K.String.empty ,
//            attributes: self.attributesPlaceholder)
//        return self
//    }
//
//    @discardableResult
//    func setPlaceHolderSize(_ size: CGFloat) -> Self {
//        self.attributesPlaceholder.updateValue(UIFont.systemFont(ofSize: size), forKey: .font)
//        _textField.attributedPlaceholder = NSAttributedString (
//            string: _textField.placeholder ?? K.String.empty ,
//            attributes: self.attributesPlaceholder)
//        return self
//    }
//
//    @discardableResult
//    func setAttributedPlaceHolder(_ attributes: NSMutableAttributedString) -> Self {
//        _textField.attributedPlaceholder = attributes
//        return self
//    }
//
//    @discardableResult
//    func setTextColor(_ textColor: UIColor) -> Self {
//        _textField.textColor = textColor
//        return self
//    }
//
//    @discardableResult
//    func setText(_ text: String) -> Self {
//        _textField.text = text
//        return self
//    }
//
//    @discardableResult
//    func setTextNumber(_ number: String, _ buildFormatter: (_ build: NumberFormatterBuilder) -> NumberFormatterBuilder ) -> Self {
//        let numberFormatter = buildFormatter(NumberFormatterBuilder())
//        if let numberFormatted = numberFormatter.getString(number) {
//            setText(numberFormatted)
//        }
//        setText(K.String.zeroDouble)
//        return self
//    }
//
//    @discardableResult
//    func setAlignment(_ textAlignment: NSTextAlignment) -> Self {
//        _textField.textAlignment = textAlignment
//        return self
//    }
//
//    @discardableResult
//    func setIsSecureText(_ flag: Bool) -> Self {
//        _textField.isSecureTextEntry = flag
//        return self
//    }
//
//    @discardableResult
//    func setAutoCapitalization(_ autoCapitalizationType: UITextAutocapitalizationType) -> Self {
//        _textField.autocapitalizationType = autoCapitalizationType
//        return self
//    }
//
//    @discardableResult
//    func setAutoCorrectionType(_ autoCorrectionType: UITextAutocorrectionType) -> Self {
//        _textField.autocorrectionType = autoCorrectionType
//        return self
//    }
//
//    @discardableResult
//    func setTintColor(_ tintColor: UIColor) -> Self {
//        _textField.tintColor = tintColor
//        return self
//    }
    
}
