
//  Created by Alessandro Comparini on 13/09/23.
//

import UIKit

@MainActor
open class KeyboardConfigurationBuilder: KeyboardConfiguration {
    static private let keyboardTypeWithOutReturn: [UIKeyboardType] = [.decimalPad, .asciiCapableNumberPad, .numberPad, .twitter, .phonePad]
    
    private(set) var completionReturnType: CompletionKeyboardAlias?
    private var completionDoneKeyboard: CompletionKeyboardAlias?
    private var completionCleanButton: CompletionKeyboardAlias?
    private var callBackListTextFields: CallBackListTextFieldsAlias?
    
    private var barButtonDone: UIBarButtonItem?
    private var isDoneButtonAlreadyIncluded = false
    private var toolBarTintColor: UIColor?
    private var toolbar: UIToolbar?
    
    private weak var textFieldBuilder: TextFieldBuilder?
    
    public init(textFieldBuilder: TextFieldBuilder) {
        self.textFieldBuilder = textFieldBuilder
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setKeyboardType(_ keyboardType: K.Keyboard.Types) -> Self {
        textFieldBuilder?.get.keyboardType = UIKeyboardType.init(rawValue: keyboardType.rawValue ) ?? .default
        if completionDoneKeyboard == nil {
            addAutomaticButtonOk()
        }
        return self
    }
    
    @discardableResult
    public func setDoneButton(title: String = K.Strings.done ,_ completion: @escaping CompletionKeyboardAlias) -> Self {
        completionDoneKeyboard = completion
        if isDoneButtonAlreadyIncluded {
            barButtonDone?.title = title
            return self
        }
        isDoneButtonAlreadyIncluded = true
        createToolbar()
        barButtonDone = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(doneButtonTapped))
        addButtonItemToToolbar(barButtonDone)
        return self
    }
    
    @discardableResult
    public func setClearButton(_ completion: CompletionKeyboardAlias? = nil) -> Self {
        completionCleanButton = completion
        createToolbar()
        addButtonItemToToolbar(createClearButtonItem())
        addButtonItemToToolbar(createFixedSpace(10))
        return self
    }
    
    @discardableResult
    public func setNavigationButtonTextField(_ callBackListTextFields: @escaping CallBackListTextFieldsAlias) -> Self {
        createToolbar()
        addNavigationsButtons()
        self.callBackListTextFields = callBackListTextFields
        return self
    }
    
    @discardableResult
    public func setKeyboardAppearance(_ appearance: K.Appearance) -> Self {
        textFieldBuilder?.get.keyboardAppearance = UIKeyboardAppearance.init(rawValue: appearance.rawValue) ?? .default
        return self
    }
    
    @discardableResult
    public func setHideKeyboard(_ hide: Bool) -> Self {
        if hide {
            textFieldBuilder?.get.resignFirstResponder()
            return self
        }
        textFieldBuilder?.get.becomeFirstResponder()
        return self
    }
    
    @discardableResult
    public func setReturnKeyType(_ returnKey: K.Keyboard.ReturnKeyType, _ completion: CompletionKeyboardAlias? = nil) -> Self {
        if let completion {
            completionReturnType = completion
        }
        textFieldBuilder?.get.returnKeyType = UIReturnKeyType.init(rawValue: returnKey.rawValue) ?? .default
        return self
    }

    @discardableResult
    public func setTintColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        toolBarTintColor = color
        toolbar?.tintColor = toolBarTintColor
        return self
    }
    
    @discardableResult
    public func setTintColor(hexColor: String?) -> Self {
        guard let hexColor, hexColor.isHexColor() else {return self}
        setTintColor(UIColor.HEX(hexColor))
        return self
    }

    
//  MARK: - PRIVATE AREA
    private func createFixedSpace(_ space: CGFloat) -> UIBarButtonItem {
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = space
        return fixedSpace
    }
    
    private func createEraseImage() -> UIImage {
        let img = ImageViewBuilder()
            .setImage(systemName: K.Images.eraser)
        return img.get.image ?? UIImage()
    }
    
    private func createClearButtonItem() -> UIBarButtonItem {
        let img = createEraseImage().applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: K.Default.imageSize))
        return UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(clearButtonTapped))
    }
    
    private func addNavigationsButtons() {
        let imgPrevious = UIImage(systemName: K.Images.chevronBackward)
        let previous = UIBarButtonItem(image: imgPrevious, style: .plain, target: self, action: #selector(navigationPreviousButtonTapped))
        let imgNext = UIImage(systemName: K.Images.chevronForward)
        let next = UIBarButtonItem(image: imgNext, style: .plain, target: self, action: #selector(navigationNextButtonTapped))
        addButtonItemToToolbar(previous)
        addButtonItemToToolbar(createFixedSpace(10))
        addButtonItemToToolbar(next)
        addButtonItemToToolbar(createFixedSpace(10))
    }
    
    private func addButtonItemToToolbar(_ barButtonItem: UIBarButtonItem?) {
        guard let toolbar, let barButtonItem else {return}
        toolbar.items?.append(barButtonItem)
        repositionDoneButtonToFirstPosition()
    }
    
    private func repositionDoneButtonToFirstPosition() {
        if let indexDone = toolbar?.items?.firstIndex(where: { $0.style == .done }) {
            let itemDone = toolbar?.items?[indexDone]
            toolbar?.items?.remove(at: indexDone)
            if let itemDone {toolbar?.items?.append(itemDone)}
        }
    }
    
    private func createToolbar() {
        if toolbar != nil {return}
        toolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        configToolbar()
        addToolbarToTextField()
        addButtonItemToToolbar(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
    }
    
    private func configToolbar() {
        toolbar?.items = []
        toolbar?.barStyle = .default
        toolbar?.sizeToFit()
        toolbar?.tintColor = toolBarTintColor
    }
    
    private func addToolbarToTextField() {
        self.textFieldBuilder?.get.inputAccessoryView = toolbar
    }
    
    private func addAutomaticButtonOk() {
        if isDoneButtonAlreadyIncluded {return}
        
        guard let keyboardType = textFieldBuilder?.get.keyboardType else {return}
        
        if KeyboardConfigurationBuilder.keyboardTypeWithOutReturn.contains(keyboardType) {
            self.setDoneButton { [weak self] textField in
                guard let self else {return}
                self.textFieldBuilder?.textFieldEditingDidEndOnExit(textField.get)
            }
        }
    }
    
        
//  MARK: - NAVIAGATION Area
    
    private func moveNextTextField(_ textField: TextFieldBuilder) {
        guard let listTextFields = callBackListTextFields?() else {return}
        guard let currentIndex = listTextFields.firstIndex(of: textField) else {return}
        let nextIndex = currentIndex + 1
        if nextIndex < listTextFields.count {
            let nextTextField = listTextFields[nextIndex]
            nextTextField.get.becomeFirstResponder()
        } else {
            listTextFields[0].get.becomeFirstResponder()
        }
    }
    
    private func movePreviousTextField(_ textField: TextFieldBuilder) {
        guard let listTextFields = callBackListTextFields?() else {return}
        guard let currentIndex = listTextFields.firstIndex(of: textField) else {return}
        
        let nextIndex = currentIndex - 1
        if nextIndex < 0 {
            listTextFields[listTextFields.count-1].get.becomeFirstResponder()
        } else {
            let nextTextField = listTextFields[nextIndex]
            nextTextField.get.becomeFirstResponder()
        }
    }
    

        
//  MARK: - OBJC Area
    @objc private func doneButtonTapped() {
        guard let textFieldBuilder else {return}
        textFieldBuilder.textFieldEditingDidEndOnExit(textFieldBuilder.get)
        completionDoneKeyboard?(textFieldBuilder)
    }
    
    @objc private func navigationNextButtonTapped() {
        guard let textFieldBuilder else {return}
        moveNextTextField(textFieldBuilder)
    }
    
    @objc private func navigationPreviousButtonTapped() {
        guard let textFieldBuilder else {return}
        movePreviousTextField(textFieldBuilder)
    }
    
    @objc private func clearButtonTapped() {
        guard let textFieldBuilder else {return}
        textFieldBuilder.get.text = ""
        completionCleanButton?(textFieldBuilder)
    }

}
