
//  Created by Alessandro Comparini on 13/09/23.
//

import UIKit

public class KeyboardConfigurationBuilder: KeyboardConfiguration {
    
    static private let keyboardTypeWithOutReturn: [UIKeyboardType] = [.decimalPad, .asciiCapableNumberPad, .numberPad, .twitter, .phonePad]
    
    private var completionDoneKeyboard: completionKeyboardAlias?
    private var callBackListTextFields: callBackListTextFieldsAlias?
    
    private var isDoneButtonAlreadyIncluded = false
    private var toolbar: UIToolbar?
    
    private weak var textField: TextFieldBuilder?
    
    public init(textField: TextFieldBuilder) {
        self.textField = textField
    }
    
    deinit {
        removeToolbarToTextField()
        toolbar = nil
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setKeyboardType(_ keyboardType: K.Keyboard.Types) -> Self {
        textField?.get.keyboardType = UIKeyboardType.init(rawValue: keyboardType.rawValue ) ?? .default
        if completionDoneKeyboard == nil {
            addAutomaticButtonOk()
        }
        return self
    }
    
    @discardableResult
    public func setDoneButton(_ completion: @escaping completionKeyboardAlias) -> Self {
        completionDoneKeyboard = completion
        if isDoneButtonAlreadyIncluded {return self}
        isDoneButtonAlreadyIncluded = true
        createToolbar()
        addButtonItemToToolbar(UIBarButtonItem(title: K.String.done, style: .done, target: self, action: #selector(doneButtonTapped)))
        return self
    }
    
    @discardableResult
    public func setClearButton() -> Self {
        createToolbar()
        addButtonItemToToolbar(createClearButtonItem())
        addButtonItemToToolbar(createFixedSpace(10))
        return self
    }
    
    @discardableResult
    public func setNavigationButtonTextField(_ callBackListTextFields: @escaping callBackListTextFieldsAlias) -> Self {
        createToolbar()
        addNavigationsButtons()
        self.callBackListTextFields = callBackListTextFields
        return self
    }
    
    @discardableResult
    public func setKeyboardAppearance(_ appearance: K.Appearance) -> Self {
        textField?.get.keyboardAppearance = UIKeyboardAppearance.init(rawValue: appearance.rawValue) ?? .default
        return self
    }
    
    @discardableResult
    public func setHideKeyboard(_ hide: Bool) -> Self {
        if hide {
            textField?.get.resignFirstResponder()
            return self
        }
        textField?.get.becomeFirstResponder()
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func createFixedSpace(_ space: CGFloat) -> UIBarButtonItem {
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = space
        return fixedSpace
    }
    
    private func createClearButtonItem() -> UIBarButtonItem {
        let img = UIImage(systemName: K.Images.eraserLineDashed)?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: K.Default.imageSize))
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
    
    private func addButtonItemToToolbar(_ barButtonItem: UIBarButtonItem) {
        guard let toolbar else {return}
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
        toolbar?.tintColor = self.textField?.get.textColor
    }
    
    private func addToolbarToTextField() {
        self.textField?.get.inputAccessoryView = toolbar
    }
    
    private func removeToolbarToTextField() {
        self.textField?.get.inputAccessoryView = nil
    }
    
    private func addAutomaticButtonOk() {
        if isDoneButtonAlreadyIncluded {return}
        guard let keyboardType = textField?.get.keyboardType else {return}
        if KeyboardConfigurationBuilder.keyboardTypeWithOutReturn.contains(keyboardType) {
            self.setDoneButton { [weak self] textField in
                guard let self else {return}
                self.textField?.textFieldEditingDidEndOnExit(textField.get)
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
        guard let textField else {return}
        textField.textFieldEditingDidEndOnExit(textField.get)
        completionDoneKeyboard?(textField)
    }
    
    @objc private func navigationNextButtonTapped() {
        guard let textField else {return}
        moveNextTextField(textField)
    }
    
    @objc private func navigationPreviousButtonTapped() {
        guard let textField else {return}
        movePreviousTextField(textField)
    }
    
    @objc private func clearButtonTapped() {
        guard let textField else {return}
        textField.get.text = ""
    }

}
