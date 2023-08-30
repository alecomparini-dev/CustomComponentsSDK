
//  Created by Alessandro Comparini on 29/08/23.
//

import UIKit

public class LabelBuilder: LabelProtocol {
    public typealias T = UILabel
    
    public var label: UILabel
    
    
//  MARK: - INITIALIZERS
    
    public init(frame: CGRect) {
        label = UILabel(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public convenience init(_ text: String) {
        self.init()
        setText(text)
    }
    
    public convenience init(_ text: String, _ hexColor: String ) {
        self.init(text)
        setColor(hexColor)
    }
    
    public convenience init(_ text: String, _ hexColor: String, _ aligment: LabelTextAlignment) {
        self.init(text, hexColor)
        setTextAlignment(aligment)
    }
    
    
//  MARK: - SET Properties
    
    @discardableResult
    public func setText(_ text: String) -> Self {
        label.text = text
        return self
    }
    
    @discardableResult
    public func setColor(_ hexColor: String) -> Self {
        label.textColor = UIColor.HEX(hexColor)
        return self
    }
    
    
    @discardableResult
    public func setTextAlignment(_ textAlignment: LabelTextAlignment) -> Self {
        label.textAlignment = NSTextAlignment.init(rawValue: textAlignment.rawValue) ?? .natural
        return self
    }
        
    @discardableResult
    public func setFontFamily(_ fontFamily: String, _ fontSize: CGFloat) -> Self {
        label.font = UIFont(name: fontFamily, size: fontSize)
        return self
    }
    
    @discardableResult
    public func setSize(_ fontSize: CGFloat) -> Self {
        label.font = label.font.withSize(fontSize)
        return self
    }
    
    @discardableResult
    public func setStyle(_ style: LabelStyleWeight) -> Self {
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: style.toFontWeight() )
        return self
    }
    
        
}

extension LabelStyleWeight {
    
    func toFontWeight() -> UIFont.Weight {
        switch self {
        case .bold:
            return .bold
        case .semibold:
            return .semibold
        case .regular:
            return .regular
        case .ultraLight:
            return .ultraLight
        case .thin:
            return .thin
        case .light:
            return .light
        case .medium:
            return .medium
        case .heavy:
            return .heavy
        case .black:
            return .black
        }
    }
}
