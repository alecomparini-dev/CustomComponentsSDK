//  Created by Alessandro Comparini on 11/10/23.
//

import Foundation

public protocol TextView {
    associatedtype T
    var get: T { get }
    
    @discardableResult
    func setInsertText(_ text: String?) -> Self
    
    @discardableResult
    func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self
    
    @discardableResult
    func setTextColor(hexColor color: String?) -> Self
    
    @discardableResult
    func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self
    
    @discardableResult
    func setSize(_ fontSize: CGFloat) -> Self
    
    @discardableResult
    func setLineSpacing(_ spacing: CGFloat) -> Self
    
    @discardableResult
    func setPadding(left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat? ) -> Self
 
    @discardableResult
    func setReadOnly(_ flag: Bool) -> Self
    
    @discardableResult
    func setClearText() -> Self
    
    @discardableResult
    func setText(_ text: String?) -> Self
}
