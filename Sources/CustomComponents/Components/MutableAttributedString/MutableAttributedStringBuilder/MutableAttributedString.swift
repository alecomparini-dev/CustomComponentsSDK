//  Created by Alessandro Comparini on 03/12/23.
//

import Foundation

public protocol MutableAttributedString {
    associatedtype T
    
    var get: NSAttributedString { get }
    
    @discardableResult
    func setText(text: String) -> Self
    
    @discardableResult
    func setImage(image: T, hexColor: String) -> Self
    
    @discardableResult
    func setAttributed(key: NSAttributedString.Key, value: Any ) -> Self
    
    
}
