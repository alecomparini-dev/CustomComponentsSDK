//  Created by Alessandro Comparini on 03/12/23.
//

import Foundation

public protocol MutableAttributedString {
    
    var get: NSAttributedString { get }
    
    @discardableResult
    func setAttributedText(text: String) -> Self
    
    
    @discardableResult
    func setAttributed(key: NSAttributedString.Key, value: Any ) -> Self
    
    
}
