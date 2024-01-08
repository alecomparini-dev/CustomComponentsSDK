//  Created by Alessandro Comparini on 03/12/23.
//

import Foundation

public protocol MutableAttributedString {
    associatedtype T
    associatedtype C
    
    var get: NSAttributedString { get }
    
    @discardableResult
    func setText(text: String) -> Self
    
    @discardableResult
    func setImage(image: T, color: C) -> Self
    
    @discardableResult
    func setImage(systemName: String, color: C) -> Self 
    
    @discardableResult
    func setAttributed(key: NSAttributedString.Key, value: Any ) -> Self
    
    
}
