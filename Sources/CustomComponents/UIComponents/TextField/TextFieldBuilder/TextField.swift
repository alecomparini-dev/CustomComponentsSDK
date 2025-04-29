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
    
    func setAttributedPlaceHolder(_ attributes: NSAttributedString?) -> Self

    func setTextContentType(_ textContentType: UIK.Keyboard.ContentType) -> Self
    
    func setText(_ text: String?) -> Self

    func setTextColor(hexColor color: String?) -> Self
    
    func setTextColor(named color: String?) -> Self

    func setTextAlignment(_ textAlignment: UIK.Text.Alignment?) -> Self

    func setIsSecureText(_ flag: Bool) -> Self
    
    func setReadOnly(_ flag: Bool) -> Self

    func setAutoCapitalization(_ autoCapitalizationType: UIK.Text.AutocapitalizationType) -> Self

    func setAutoCorrectionType(_ autoCorrectionType: UIK.Text.AutocorrectionType) -> Self

    func setTintColor(hexColor color: String?) -> Self
    
    func setTintColor(named color: String?) -> Self
    
    func setPadding(_ padding: CGFloat?, _ position: UIK.Position.Horizontal?) -> Self
    
    func setPadding(_ paddingView: BaseBuilder?, _ position: UIK.Position.Horizontal?, _ mode: UIK.TextField.ViewMode ) -> Self
    
    func setFocus() -> Self

    func setHideKeyboard() -> Self
    
    func setKeyboard(_ configKeyboard: (_ build: KeyboardConfigurationBuilder) -> KeyboardConfigurationBuilder ) -> Self

    func setMask(_ configMask: (_ build: MaskBuilder) -> MaskBuilder ) -> Self
    
    func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self
    
    func setClearButton(_ build: ((_ build: ClearButtonModeBuilder) -> ClearButtonModeBuilder)? ) -> Self
    
    func setAdjustsFontSizeToFitWidth(minimumFontSize: CGFloat) -> Self

}
