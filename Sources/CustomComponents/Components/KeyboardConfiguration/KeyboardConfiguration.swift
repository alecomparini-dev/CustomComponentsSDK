//  Created by Alessandro Comparini on 13/09/23.
//

import Foundation

public protocol KeyboardConfiguration {
    typealias callBackListTextFieldsAlias = () -> [TextFieldBuilder]
    typealias completionKeyboardAlias = (_ textField: TextFieldBuilder) -> Void
    
    @discardableResult
    func setKeyboardType(_ keyboardType: K.Keyboard.Types) -> Self
    
    @discardableResult
    func setDoneButton(_ completion: @escaping completionKeyboardAlias) -> Self
    
    @discardableResult
    func setClearButton() -> Self
    
    @discardableResult
    func setNavigationButtonTextField(_ callBackListTextFields: @escaping callBackListTextFieldsAlias ) -> Self

    @discardableResult
    func setKeyboardAppearance(_ appearance: K.Appearance) -> Self
    
    @discardableResult
    func setHideKeyboard(_ hide: Bool) -> Self
    
    @discardableResult
    func setReturnKeyType(_ returnKey: K.Keyboard.ReturnKeyType) -> Self
    
}
