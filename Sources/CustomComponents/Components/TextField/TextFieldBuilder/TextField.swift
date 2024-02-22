//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

public protocol TextField {
    associatedtype T
    var get: T { get }
    
    @discardableResult
    func setPlaceHolder(_ placeholder: String?) -> Self
    
    @discardableResult
    func setPlaceHolderColor(hexColor color: String?) -> Self
    
    @discardableResult
    func setPlaceHolderColor(named color: String?) -> Self

    @discardableResult
    func setPlaceHolderSize(_ size: CGFloat?) -> Self
    
    @discardableResult
    func setAttributedPlaceHolder(_ attributes: NSMutableAttributedString?) -> Self

    @discardableResult
    func setTextContentType(_ textContentType: K.Keyboard.ContentType) -> Self
    
    @discardableResult
    func setText(_ text: String?) -> Self

    @discardableResult
    func setTextColor(hexColor color: String?) -> Self
    
    @discardableResult
    func setTextColor(named color: String?) -> Self

    @discardableResult
    func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self

    @discardableResult
    func setIsSecureText(_ flag: Bool) -> Self
    
    @discardableResult
    func setReadOnly(_ flag: Bool) -> Self

    @discardableResult
    func setAutoCapitalization(_ autoCapitalizationType: K.Text.AutocapitalizationType) -> Self

    @discardableResult
    func setAutoCorrectionType(_ autoCorrectionType: K.Text.AutocorrectionType) -> Self

    @discardableResult
    func setTintColor(hexColor color: String?) -> Self
    
    @discardableResult
    func setTintColor(named color: String?) -> Self
    
    @discardableResult
    func setPadding(_ padding: CGFloat?, _ position: K.Position.Horizontal?) -> Self
    
    @discardableResult
    func setPadding(_ paddingView: BaseBuilder?, _ position: K.Position.Horizontal?) -> Self
    
    @discardableResult
    func setFocus() -> Self

    @discardableResult
    func setKeyboard(_ configKeyboard: (_ build: KeyboardConfigurationBuilder) -> KeyboardConfigurationBuilder ) -> Self

    @discardableResult
    func setMask(_ configMask: (_ build: MaskBuilder) -> MaskBuilder ) -> Self
    
    @discardableResult
    func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self


}
