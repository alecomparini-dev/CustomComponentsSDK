//  Created by Alessandro Comparini on 02/09/23.
//

import Foundation

public protocol Button {
    associatedtype T
    var get: T { get }
    
    func setTitle(_ title: String?) -> Self

    func setTitleColor(hexColor: String?) -> Self
    
    func setTitleColor(named: String?) -> Self
    
    func setTintColor(hexColor: String?) -> Self
    
    func setTintColor(named: String?) -> Self
    
    func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self
    
    func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat? ) -> Self
    
    func setTitleSize(_ fontSize: CGFloat? ) -> Self
    
    func setTitleWeight(_ weight: K.Weight? ) -> Self
    
}
