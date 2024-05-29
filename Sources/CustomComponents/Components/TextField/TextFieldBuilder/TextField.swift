//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

@MainActor
public protocol TextField {
    associatedtype T
    var get: T { get }
    
    func setPlaceHolder(_ placeholder: String?) -> Self
    
    func setPlaceHolderColor(hexColor color: String?) -> Self
    
    func setPlaceHolderColor(named color: String?) -> Self

    func setPlaceHolderSize(_ size: CGFloat?) -> Self
    
    func setAttributedPlaceHolder(_ attributes: NSMutableAttributedString?) -> Self

    func setTextContentType(_ textContentType: K.Keyboard.ContentType) -> Self
    
    func setText(_ text: String?) -> Self

    func setTextColor(hexColor color: String?) -> Self
    
    func setTextColor(named color: String?) -> Self

    func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self

    func setIsSecureText(_ flag: Bool) -> Self
    
    func setReadOnly(_ flag: Bool) -> Self

    func setAutoCapitalization(_ autoCapitalizationType: K.Text.AutocapitalizationType) -> Self

    func setAutoCorrectionType(_ autoCorrectionType: K.Text.AutocorrectionType) -> Self

    func setTintColor(hexColor color: String?) -> Self
    
    func setTintColor(named color: String?) -> Self
    
    func setPadding(_ padding: CGFloat?, _ position: K.Position.Horizontal?) -> Self
    
    func setPadding(_ paddingView: BaseBuilder?, _ position: K.Position.Horizontal?, _ mode: K.TextField.ViewMode ) -> Self
    
    func setFocus() -> Self

    func setHideKeyboard() -> Self
    
    func setKeyboard(_ configKeyboard: (_ build: KeyboardConfigurationBuilder) -> KeyboardConfigurationBuilder ) -> Self

    func setMask(_ configMask: (_ build: MaskBuilder) -> MaskBuilder ) -> Self
    
    func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self
    
    func setClearButton(_ build: ((_ build: ClearButtonModeBuilder) -> ClearButtonModeBuilder)? ) -> Self
    
    func setAdjustsFontSizeToFitWidth(minimumFontSize: CGFloat) -> Self

}
