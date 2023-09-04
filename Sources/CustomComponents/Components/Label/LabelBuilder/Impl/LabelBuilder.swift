
//  Created by Alessandro Comparini on 29/08/23.
//

import UIKit

open class LabelBuilder: BaseBuilder {
    public typealias T = UILabel
    public var get: UILabel {self.label}
    
    private var label: UILabel
    
    
//  MARK: - INITIALIZERS
        
    public init() {
        label = UILabel(frame: .zero)
        super.init(label)
    }
    
    public convenience init(_ text: String) {
        self.init()
        setText(text)
    }
    
    public convenience init(_ text: String, _ hexColor: String ) {
        self.init(text)
        setColor(hexColor: hexColor)
    }
    
    public convenience init(_ text: String, _ hexColor: String, _ aligment: K.Text.Alignment) {
        self.init(text, hexColor)
        setTextAlignment(aligment)
    }
    
    
//  MARK: - SET Properties
    
    @discardableResult
    public func setText(_ text: String?) -> Self {
        guard let text else {return self}
        label.text = text
        return self
    }
    
    @discardableResult
    public func setColor(hexColor: String?) -> Self {
        guard let hexColor else {return self}
        label.textColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self {
        guard let textAlignment else {return self}
        label.textAlignment = NSTextAlignment.init(rawValue: textAlignment.rawValue) ?? .natural
        return self
    }
        
    @discardableResult
    public func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self {
        guard let fontFamily else {return self}
        label.font = UIFont(name: fontFamily, size: fontSize ?? K.Default.fontSize)
        return self
    }
    
    @discardableResult
    public func setSize(_ fontSize: CGFloat?) -> Self {
        guard let fontSize else {return self}
        label.font = label.font.withSize(fontSize)
        return self
    }
    
    @discardableResult
    public func setWeight(_ weight: K.Weight?) -> Self {
        guard let weight else {return self}
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: weight.toFontWeight() )
        return self
    }
    
        
}


//  MARK: - EXTENSION WEIGHT
public extension K.Weight {
    
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
