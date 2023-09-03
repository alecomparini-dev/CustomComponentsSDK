//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

open class TextFieldBuilder: BaseBuilder, TextField {
    public typealias T = UITextField
    public var get: UITextField { self.textField }
    
    private var attributesPlaceholder: [NSAttributedString.Key: Any] = [:]
    private var textField: UITextField
    

//  MARK: - INITIALIZERS
    
    public init() {
        self.textField = UITextField(frame: .zero)
        super.init(textField)
        configure()
    }
    
    convenience init(_ placeHolder: String) {
        self.init()
        setPlaceHolder(placeHolder)
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setPlaceHolder(_ placeholder: String) -> Self {
        textField.attributedPlaceholder = NSAttributedString (
            string: placeholder,
            attributes: self.attributesPlaceholder)
        return self
    }

    @discardableResult
    public func setPlaceHolderColor(hexColor: String) -> Self {
        self.attributesPlaceholder.updateValue(UIColor.HEX(hexColor), forKey: .foregroundColor)
        textField.attributedPlaceholder = NSAttributedString (
            string: textField.placeholder ?? K.String.empty ,
            attributes: self.attributesPlaceholder)
        return self
    }

    @discardableResult
    public func setPlaceHolderSize(_ size: CGFloat) -> Self {
        self.attributesPlaceholder.updateValue(UIFont.systemFont(ofSize: size), forKey: .font)
        textField.attributedPlaceholder = NSAttributedString (
            string: textField.placeholder ?? K.String.empty ,
            attributes: self.attributesPlaceholder)
        return self
    }

    @discardableResult
    public func setAttributedPlaceHolder(_ attributes: NSMutableAttributedString) -> Self {
        textField.attributedPlaceholder = attributes
        return self
    }

    @discardableResult
    public func setTextColor(hexColor: String) -> Self {
        textField.textColor = UIColor.HEX(hexColor)
        return self
    }

    @discardableResult
    public func setText(_ text: String) -> Self {
        textField.text = text
        return self
    }

    @discardableResult
    public func setTextAlignment(_ textAlignment: K.Text.Alignment) -> Self {
        textField.textAlignment = NSTextAlignment.init(rawValue: textAlignment.rawValue) ?? .left
        return self
    }

    @discardableResult
    public func setIsSecureText(_ flag: Bool) -> Self {
        textField.isSecureTextEntry = flag
        return self
    }

    @discardableResult
    public func setAutoCapitalization(_ autoCapitalizationType: K.Text.AutocapitalizationType) -> Self {
        textField.autocapitalizationType = UITextAutocapitalizationType.init(rawValue: autoCapitalizationType.rawValue) ?? .none
        return self
    }

    @discardableResult
    public func setAutoCorrectionType(_ autoCorrectionType: K.Text.AutocorrectionType) -> Self {
        textField.autocorrectionType = UITextAutocorrectionType.init(rawValue: autoCorrectionType.rawValue) ?? .default
        return self
    }

    @discardableResult
    public func setTintColor(hexColor: String) -> Self {
        textField.tintColor = UIColor.HEX(hexColor)
        return self
    }


    // MARK: - PADDING
    @discardableResult
    public func setPadding(_ padding: CGFloat, _ position: K.Position.Horizontal? = nil) -> Self {
        let paddingView = ViewBuilder(frame: CGRect(x: .zero, y: .zero, width: padding, height: .zero))
        setPadding(paddingView, position)
        return self
    }
    
    @discardableResult
    public func setPadding(_ paddingView: BaseBuilder, _ position: K.Position.Horizontal? = nil) -> Self {
        if let position {
            addPaddingToTextField(paddingView, position)
            return self
        }
        addPaddingToTextField(paddingView, .left)
        addPaddingToTextField(paddingView, .right)
        return self
    }
    
    
//  MARK: - PRIVATE Area
    
    private func configure() {
        setPadding(K.Default.padding)
    }
    
    private func addPaddingToTextField(_ paddingView: BaseBuilder, _ position: K.Position.Horizontal ) {
        switch position {
            case .left:
                textField.leftView = paddingView.baseView
                textField.leftViewMode = .always
            
            case .right:
                textField.rightView = paddingView.baseView
                textField.rightViewMode = .always
        }
    }

}
