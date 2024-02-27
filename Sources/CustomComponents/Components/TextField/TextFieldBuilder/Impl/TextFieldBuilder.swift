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
        currentMainWindow = mainWindow
    }

    private var clearButton: ClearButtonModeBuilder?
    private var keyboardConfiguration: KeyboardConfigurationBuilder?
    private var mask: MaskBuilder?
    
    private var attributesPlaceholder: [NSAttributedString.Key: Any] = [:]
    private var textField: UITextField
    

//  MARK: - INITIALIZERS
    
    public init() {
        self.textField = UITextField(frame: .zero)
        super.init(textField)
        configure()
    }
    
    public convenience init(placeHolder: String) {
        self.init()
        setPlaceHolder(placeHolder)
    }
    
    deinit {
        clearButton = nil
        keyboardConfiguration = nil
    }
    
        
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setPlaceHolder(_ placeholder: String?) -> Self {
        guard let placeholder else {return self}
        setPlaceHolderColor(.lightGray)
        textField.attributedPlaceholder = NSAttributedString (
            string: placeholder,
            attributes: self.attributesPlaceholder)
        return self
    }
    
    @discardableResult
    public func setPlaceHolderColor(_ color: UIColor?) -> Self {
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
        setPlaceHolderColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setPlaceHolderColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setPlaceHolderColor(namedColor)
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
    public func setTextColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        textField.textColor = color
        return self
    }
    
    @discardableResult
    public func setTextColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTextColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setTextColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setTextColor(namedColor )
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
    public func setReadOnly(_ flag: Bool) -> Self {
        textField.isEnabled = !flag
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
    public func setTintColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        textField.tintColor = color
        return self
    }
    
    @discardableResult
    public func setTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTintColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setTintColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setTintColor(namedColor)
        return self
    }

    @discardableResult
    public func setFocus() -> Self {
        textField.becomeFirstResponder()
        return self
    }

    @discardableResult
    public func setKeyboard(_ configKeyboard: (_ build: KeyboardConfigurationBuilder) -> KeyboardConfigurationBuilder ) -> Self {
        keyboardConfiguration = configKeyboard(KeyboardConfigurationBuilder(textFieldBuilder: self))
        return self
    }

    @discardableResult
    public func setMask(_ configMask: (_ build: MaskBuilder) -> MaskBuilder) -> Self {
        mask = configMask(MaskBuilder())
        return self
    }
    

    @discardableResult
    public func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self {
        guard let fontFamily else {return self}
        if let font = UIFont(name: fontFamily, size: fontSize ?? K.Default.fontSize) {
            textField.font = font
        }
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
    public func setPadding(_ paddingView: BaseBuilder?, _ position: K.Position.Horizontal? = nil, _ mode: K.TextField.ViewMode = .always ) -> Self {
        guard let paddingView else {return self}
        if let position {
            addPaddingToTextField(paddingView, position, mode)
            return self
        }
        addPaddingToTextField(paddingView, .left, mode)
        addPaddingToTextField(paddingView, .right, mode)
        return self
    }
    
    
    
//  MARK: - SET CLEAR BUTTON MODE
    
    @discardableResult
    public func setClearButton(size: CGSize = CGSize(width: 20, height: 20) , _ imgSystemName: String = K.Images.xCircleFill) -> Self {
        textField.clearButtonMode = .whileEditing
//        addPaddingToTextField(createClearButtonView(size, imgSystemName), .right, .whileEditing)
        setPadding(createClearButtonView(size, imgSystemName), .right, .whileEditing)
        return self
    }
    
    @objc
    private func clearButtonTapped() {
        self.setText("")
    }
    
    private func createClearButtonView(_ size: CGSize, _ imgSystemName: String) -> ViewBuilder {
        let view = ViewBuilder(frame: CGRect(x: 0, y: 0, width: size.width + 10, height: size.height))
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: imgSystemName), for: .normal)
        clearButton.frame = CGRect(origin: .zero, size: size)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        view.get.addSubview(clearButton)
        return view
    }
    
    
    @discardableResult
    public func setClearButton(_ build: (_ build: ClearButtonModeBuilder) -> ClearButtonModeBuilder ) -> Self {
        clearButton = build(ClearButtonModeBuilder(textFieldBuilder: self))
        return self
    }
                            

// MARK: - DELEGATE
    @discardableResult
    public func setDelegate(_ delegate: UITextFieldDelegate) -> Self {
        textField.delegate = delegate
        return self
    }

    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        setPadding(K.Default.padding)
        configDelegate()
        setAutoCorrectionType(.no)
        addHideKeyboardWhenTouchReturn()
    }
    
    private func configDelegate() {
        textField.delegate = self
    }
    
    private func addPaddingToTextField(_ paddingView: BaseBuilder, _ position: K.Position.Horizontal, _ mode: K.TextField.ViewMode = .always ) {
        switch position {
            case .left:
                textField.leftView = paddingView.baseView
                textField.leftViewMode = UITextField.ViewMode(rawValue: mode.rawValue) ?? .always
            
            case .right:
                textField.rightView = paddingView.baseView
                textField.rightViewMode = UITextField.ViewMode(rawValue: mode.rawValue) ?? .always
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
        self.textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
        TextFieldBuilder.hideKeyboardWhenViewTapped()
    }
    
    
//  MARK: - @OBJC FUNCTION AREA
    @objc
    public func textFieldEditingDidEndOnExit(_ textField: UITextField) {
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
        if let completion = keyboardConfiguration?.completionReturnType {
            completion(self)
            return true
        }
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let mask {
            textField.text = mask.formatStringWithRange(range: range, string: string)
            return false
        }
        
        return true
    }
}


