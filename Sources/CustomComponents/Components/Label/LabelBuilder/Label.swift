//  Created by Alessandro Comparini on 29/08/23.
//

import Foundation

public protocol Label: AnyObject {
    associatedtype T
    associatedtype N
    
    var get: T { get }
    
    @discardableResult
    func setText(_ text: String?) -> Self
    
    @discardableResult
    func setTextAttributed(_ attributedText: N) -> Self
    
    @discardableResult
    func setNumberOfLines(_ number: Int ) -> Self
    
    @discardableResult
    func setColor(hexColor: String?) -> Self
    
    @discardableResult
    func setColor(named: String?) -> Self

    @discardableResult
    func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self
    
    @discardableResult
    func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self
    
    @discardableResult
    func setItalicFont() -> Self
    
    @discardableResult
    func setSize(_ fontSize: CGFloat? ) -> Self
    
    @discardableResult
    func setWeight(_ weight: K.Weight? ) -> Self
    
}



