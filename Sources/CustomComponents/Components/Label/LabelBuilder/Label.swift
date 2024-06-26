//  Created by Alessandro Comparini on 29/08/23.
//

import Foundation

@MainActor
public protocol Label: AnyObject {
    associatedtype T
    
    var get: T { get }
    
    @discardableResult
    func setText(_ text: String?) -> Self
    
    @discardableResult
    func setTextAttributed(_ attributedText: NSMutableAttributedString) -> Self
    
    @discardableResult
    func setTextAttributed(_ build: (_ build: MutableAttributedStringBuilder) -> MutableAttributedStringBuilder) -> Self 
    
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
    
    @discardableResult
    func setAdjustsFontSizeToFitWidth(_ minimumScaleFactor: CGFloat ) -> Self
    
    
}



