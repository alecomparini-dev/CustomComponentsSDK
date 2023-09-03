//  Created by Alessandro Comparini on 02/09/23.
//

import Foundation

public protocol Button {
    associatedtype T
    var get: T { get }
    
    @discardableResult
    func setTitle(_ title: String) -> Self

    @discardableResult
    func setTitleColor(hexColor: String) -> Self
    
    @discardableResult
    func setTintColor(hexColor: String) -> Self
    
    @discardableResult
    func setTextAlignment(_ textAlignment: K.Text.Alignment) -> Self
    
    @discardableResult
    func setFontFamily(_ fontFamily: String, _ fontSize: CGFloat ) -> Self
    
    @discardableResult
    func setTitleSize(_ fontSize: CGFloat ) -> Self
    
    @discardableResult
    func setTitleWeight(_ weight: K.Text.Weight ) -> Self
    
}
