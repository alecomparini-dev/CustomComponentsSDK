//  Created by Alessandro Comparini on 03/12/23.
//

import UIKit

open class MutableAttributedStringBuilder: MutableAttributedString {
    public var get: NSAttributedString { attrText }
    
    private var attributes: [NSAttributedString.Key : Any] = [:]
    private let attrText: NSMutableAttributedString
    private var text: String
    
    public init() {
        self.attrText = NSMutableAttributedString()
        self.text = ""
    }
    
    @discardableResult
    public func setText(text: String) -> Self {
        self.text = text
        attrText.append(NSAttributedString(string: text))
        return self
    }
    
    @discardableResult
    public func setImage(systemName: String) -> Self {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: systemName)
        let attributedString = NSAttributedString(attachment: attachment)
        attrText.append(attributedString)
        return self
    }
    
    @discardableResult
    public func setAttributed(key: NSAttributedString.Key, value: Any ) -> Self {
        attributes.updateValue(value, forKey: key)
        attrText.addAttributes(attributes, range: NSRange(location: attrText.string.count-text.count, length: text.count))
        return self
    }
    
    
}
