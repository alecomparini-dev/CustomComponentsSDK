
//  Created by Alessandro Comparini on 29/08/23.
//

import UIKit

open class LabelBuilder: BaseBuilder, Label {
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
        label.text = text
        return self
    }

    @discardableResult
    public func setNumberOfLines(_ number: Int ) -> Self {
        label.numberOfLines = number
        return self
    }

    @discardableResult
    public func setColor(color: UIColor?) -> Self {
        guard let color else {return self}
        label.textColor = color
        return self
    }
    
    @discardableResult
    public func setColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setColor(color: UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setColor(color: namedColor)
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
        if let font = UIFont(name: fontFamily, size: fontSize ?? K.Default.fontSize) {
            label.font = font
        }
        return self
    }
    
    @discardableResult
    public func setItalicFont() -> Self {
        if let currentFont = label.font {
            let descriptor = currentFont.fontDescriptor
            let descriptorWithTraits = descriptor.withSymbolicTraits([.traitBold, .traitItalic])!
            label.font = UIFont(descriptor: descriptorWithTraits, size: label.font.pointSize)
        }
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
