//  Created by Alessandro Comparini on 29/08/23.
//

import Foundation

public enum LabelTextAlignment: Int {
    case left = 0
    case center = 1
    case right = 2
    case justified = 3
    case natural = 4
}

public enum LabelStyleWeight: Int {
    case bold = 0
    case semibold = 1
    case regular = 2
    case ultraLight = 3
    case thin = 4
    case light = 5
    case medium = 6
    case heavy = 7
    case black = 8
}

public protocol LabelProtocol: AnyObject {
    associatedtype T
    var label: T { get }
    
    @discardableResult
    func setText(_ text: String) -> Self
    
    @discardableResult
    func setColor(_ hexColor: String) -> Self
    
    @discardableResult
    func setTextAlignment(_ textAlignment: LabelTextAlignment) -> Self
    
    @discardableResult
    func setFontFamily(_ fontFamily: String, _ fontSize: CGFloat ) -> Self
    
    @discardableResult
    func setSize(_ fontSize: CGFloat ) -> Self
    
    @discardableResult
    func setStyle(_ style: LabelStyleWeight) -> Self
}
