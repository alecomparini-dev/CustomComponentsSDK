//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

open class TextFieldBuilder: BaseBuilder, TextField {
    
    public typealias T = UITextField
    public var get: UITextField { self.textField }

    static private var currentMainWindow: UIWindow?
    static private func hideKeyboardWhenViewTapped() {
        let mainWindow = CurrentWindow.get
        if (mainWindow == currentMainWindow) { return }
        mainWindow?.hideKeyboardWhenViewTapped()
        RootView.get?.hideKeyboardWhenViewTapped()
        currentMainWindow = mainWindow
    }

    private var keyboardConfiguration: KeyboardConfigurationBuilder?
    
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
            string: textField.placeholder ?? K.Strings.empty ,
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
            string: textField.placeholder ?? K.Strings.empty ,
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
    public func setTextContentType(_ textContentType: K.Keyboard.ContentType) -> Self {
        textField.textContentType = textContentType.toUITextContextType()
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
        textField.spellCheckingType = .no
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

    @discardableResult
    public func setKeyboard(_ configKeyboard: (_ build: KeyboardConfigurationBuilder) -> KeyboardConfigurationBuilder ) -> Self {
        keyboardConfiguration = configKeyboard(KeyboardConfigurationBuilder(textFieldBuilder: self))
        return self
    }
    
    @discardableResult
    public func setFocus() -> Self {
        textField.becomeFirstResponder()
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
//        addHideKeyboardWhenTouchReturn()
        TextFieldBuilder.hideKeyboardWhenViewTapped()
        setAutoCorrectionType(.no)
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

    private func validateKeyboardDecimal(_ character: String) -> Bool {
        guard let text = textField.text else { return true}
        let separators: [String] = [K.Strings.dot, K.Strings.comma]
        if separators.contains(character) {
            return !separators.contains { separator in
                return text.contains(separator)
            }
        }
        return true
    }
    
    private func addHideKeyboardWhenTouchReturn(){
//        textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
        
    }

    
//  MARK: - @OBJC FUNCTION AREA
    @objc public func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}



//  MARK: - EXTENSION
extension K.Keyboard.ContentType {
    
    func toUITextContextType() -> UITextContentType {
        switch self {
        case .name:
            return .name
        case .namePrefix:
            return .namePrefix
        case .givenName:
            return .givenName
        case .middleName:
            return .middleName
        case .familyName:
            return .familyName
        case .nameSuffix:
            return .nameSuffix
        case .nickname:
            return .nickname
        case .jobTitle:
            return .jobTitle
        case .organizationName:
            return .organizationName
        case .location:
            return .location
        case .fullStreetAddress:
            return .fullStreetAddress
        case .streetAddressLine1:
            return .streetAddressLine1
        case .streetAddressLine2:
            return .streetAddressLine2
        case .addressCity:
            return .addressCity
        case .addressState:
            return .addressState
        case .addressCityAndState:
            return .addressCityAndState
        case .sublocality:
            return .sublocality
        case .countryName:
            return .countryName
        case .postalCode:
            return .postalCode
        case .telephoneNumber:
            return .telephoneNumber
        case .emailAddress:
            return .emailAddress
        case .URL:
            return .URL
        case .creditCardNumber:
            return .creditCardNumber
        case .username:
            return .username
        case .password:
            return .password
        case .newPassword:
            return .newPassword
        case .oneTimeCode:
            return .oneTimeCode
        case .empty:
            return .oneTimeCode
        }
    }
    
}



//  MARK: - EXTENSION - UITextFieldDelegate
extension TextFieldBuilder: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyboardConfiguration?.completionReturnType?(self)
        textField.resignFirstResponder()
        return true
    }
    
}
