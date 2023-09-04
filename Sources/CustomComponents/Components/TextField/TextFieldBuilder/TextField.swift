//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

public protocol TextField {
    associatedtype T
    var get: T { get }
    
    func setPlaceHolder(_ placeholder: String?) -> Self
    
    func setPlaceHolderColor(hexColor: String?) -> Self

    func setPlaceHolderSize(_ size: CGFloat?) -> Self
    
    func setAttributedPlaceHolder(_ attributes: NSMutableAttributedString?) -> Self

    func setText(_ text: String?) -> Self

    func setTextColor(hexColor: String?) -> Self

    func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self

    func setIsSecureText(_ flag: Bool) -> Self

    func setAutoCapitalization(_ autoCapitalizationType: K.Text.AutocapitalizationType?) -> Self

    func setAutoCorrectionType(_ autoCorrectionType: K.Text.AutocorrectionType?) -> Self

    func setTintColor(hexColor: String?) -> Self
    
    func setPadding(_ padding: CGFloat?, _ position: K.Position.Horizontal?) -> Self
    
    func setPadding(_ paddingView: BaseBuilder?, _ position: K.Position.Horizontal?) -> Self 
    

}
