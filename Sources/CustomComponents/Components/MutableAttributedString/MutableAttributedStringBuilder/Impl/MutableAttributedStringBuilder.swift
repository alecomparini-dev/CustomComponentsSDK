//  Created by Alessandro Comparini on 03/12/23.
//

import UIKit

open class MutableAttributedStringBuilder: MutableAttributedString {
    public typealias T = UIImage
    public typealias C = UIColor

    private var attributes: [NSAttributedString.Key : Any] = [:]
    private let attrText: NSMutableAttributedString
    private var text: String
    
    public init() {
        self.attrText = NSMutableAttributedString()
        self.text = ""
    }

//  MARK: - GET PROPERTIES AREA

    public var get: NSAttributedString { attrText }
    
    
//  MARK: - SET PROPERTIES AREA
    
    @discardableResult
    public func setText(text: String) -> Self {
        self.text = text
        attrText.append(NSAttributedString(string: text))
        return self
    }
    
    @discardableResult
    public func setImage(image img: UIImage, color: UIColor = .white, size: CGRect? = nil) -> Self {
        let attachment = NSTextAttachment()
        
        attachment.image = img.withRenderingMode(.alwaysTemplate)
        
        if let size { attachment.bounds = size }
        
        attachment.image = attachment.image?.withTintColor(color)
        
        let attributedString = NSAttributedString(attachment: attachment)
        
        attrText.append(attributedString)
        return self
    }
    
    @discardableResult
    public func setImage(systemName img: String, color: UIColor = .white, size: CGRect? = nil) -> Self {
        if let img = UIImage(systemName: img) {
            setImage(image: img, color: color, size: size)
        }
        return self
    }
    
    @discardableResult
    public func setAttributed(key: NSAttributedString.Key, value: Any ) -> Self {
        attributes.updateValue(value, forKey: key)
        attrText.addAttributes(attributes, range: NSRange(location: attrText.string.count-text.count, length: text.count))
        return self
    }
    
    
}
