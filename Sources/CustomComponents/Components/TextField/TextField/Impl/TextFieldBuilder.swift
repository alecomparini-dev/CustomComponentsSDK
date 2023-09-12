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
    public func setPlaceHolder(_ placeholder: String?) -> Self {
        guard let placeholder else {return self}
        textField.attributedPlaceholder = NSAttributedString (
            string: placeholder,
            attributes: self.attributesPlaceholder)
        return self
    }

    
    @discardableResult
    public func setPlaceHolderColor(color: UIColor?) -> Self {
        guard let color else {return self}
        self.attributesPlaceholder.updateValue(color, forKey: .foregroundColor)
        textField.attributedPlaceholder = NSAttributedString (
            string: textField.placeholder ?? K.String.empty ,
            attributes: self.attributesPlaceholder)
        return self
    }
    
    @discardableResult
    public func setPlaceHolderColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setPlaceHolderColor(color: UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setPlaceHolderColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setPlaceHolderColor(color: namedColor)
        return self
    }
    
    @discardableResult
    public func setPlaceHolderSize(_ size: CGFloat?) -> Self {
        guard let size else {return self}
        self.attributesPlaceholder.updateValue(UIFont.systemFont(ofSize: size), forKey: .font)
        textField.attributedPlaceholder = NSAttributedString (
            string: textField.placeholder ?? K.String.empty ,
            attributes: self.attributesPlaceholder)
        return self
    }

    @discardableResult
    public func setAttributedPlaceHolder(_ attributes: NSMutableAttributedString?) -> Self {
        guard let attributes else {return self}
        textField.attributedPlaceholder = attributes
        return self
    }

    @discardableResult
    public func setTextColor(color: UIColor?) -> Self {
        guard let color else {return self}
        textField.textColor = color
        return self
    }
    
    @discardableResult
    public func setTextColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTextColor(color: UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setTextColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setTextColor(color: namedColor )
        return self
    }

    @discardableResult
    public func setText(_ text: String?) -> Self {
        guard let text else {return self}
        textField.text = text
        return self
    }

    @discardableResult
    public func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self {
        guard let textAlignment else {return self}
        textField.textAlignment = NSTextAlignment.init(rawValue: textAlignment.rawValue) ?? .left
        return self
    }

    @discardableResult
    public func setIsSecureText(_ flag: Bool) -> Self {
        textField.isSecureTextEntry = flag
        return self
    }

    @discardableResult
    public func setAutoCapitalization(_ autoCapitalizationType: K.Text.AutocapitalizationType?) -> Self {
        guard let autoCapitalizationType else {return self}
        textField.autocapitalizationType = UITextAutocapitalizationType.init(rawValue: autoCapitalizationType.rawValue) ?? .none
        return self
    }

    @discardableResult
    public func setAutoCorrectionType(_ autoCorrectionType: K.Text.AutocorrectionType?) -> Self {
        guard let autoCorrectionType else {return self}
        textField.autocorrectionType = UITextAutocorrectionType.init(rawValue: autoCorrectionType.rawValue) ?? .default
        return self
    }

    
    @discardableResult
    public func setTintColor(color: UIColor?) -> Self {
        guard let color else {return self}
        textField.tintColor = color
        return self
    }
    
    @discardableResult
    public func setTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTintColor(color: UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setTintColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setTintColor(color: namedColor)
        return self
    }


    // MARK: - PADDING
    @discardableResult
    public func setPadding(_ padding: CGFloat?, _ position: K.Position.Horizontal? = nil) -> Self {
        guard let padding else {return self}
        let paddingView = ViewBuilder(frame: CGRect(x: .zero, y: .zero, width: padding, height: .zero))
        setPadding(paddingView, position)
        return self
    }
    
    @discardableResult
    public func setPadding(_ paddingView: BaseBuilder?, _ position: K.Position.Horizontal? = nil) -> Self {
        guard let paddingView else {return self}
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
        configDelegate()
    }
    
    private func configDelegate() {
        textField.delegate = self
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



//  MARK: - EXTENSION - UITextFieldDelegate
extension TextFieldBuilder: UITextFieldDelegate {
    
    
    
}
