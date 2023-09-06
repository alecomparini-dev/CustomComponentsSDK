//  Created by Alessandro Comparini on 29/08/23.
//

import Foundation

public protocol Label: AnyObject {
    associatedtype T
    var get: T { get }
    
    func setText(_ text: String?) -> Self
    
    func setColor(hexColor: String?) -> Self
    
    func setColor(named: String?) -> Self

    func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self
    
    func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self
    
    func setItalicFont() -> Self
    
    func setSize(_ fontSize: CGFloat? ) -> Self
    
    func setWeight(_ weight: K.Weight? ) -> Self
}
