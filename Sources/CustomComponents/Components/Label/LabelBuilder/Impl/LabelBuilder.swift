
//  Created by Alessandro Comparini on 29/08/23.
//

import UIKit

open class LabelBuilder: BaseBuilder, Label {
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
    public func setTextAttributed(_ attributedText: NSMutableAttributedString) -> Self {
        label.attributedText = attributedText
        
        // Criar uma NSMutableAttributedString
        let attributedString = NSMutableAttributedString(string: "Texto Atribuído")

        // Adicionar atributos para personalizar a aparência
        attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 5)) // Cor vermelha para os primeiros 5 caracteres
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: NSRange(location: 6, length: 9)) // Fonte negrito e tamanho 18 para os próximos 9 caracteres

        // Criar um UILabel para exibir o texto atribuído
        let label = UILabel()
        label.attributedText = attributedString
            
        return self
    }

    @discardableResult
    public func setNumberOfLines(_ number: Int ) -> Self {
        label.numberOfLines = number
        return self
    }

    @discardableResult
    public func setColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        label.textColor = color
        return self
    }
    
    @discardableResult
    public func setColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setColor( namedColor)
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
    
    @discardableResult
    public override func setShadow(_ build: (_ build: ShadowBuilder) -> ShadowBuilder) -> Self {
        let shadowLayer = build(ShadowBuilder(UIView()))
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(cgColor: shadowLayer.shadow.shadowColor ?? UIColor.black.cgColor)
        shadow.shadowOffset = shadowLayer.shadow.shadowOffset
        shadow.shadowBlurRadius = shadowLayer.shadow.shadowRadius

        let attrText = NSMutableAttributedString(
            string: label.text ?? "",
            attributes: [
                NSAttributedString.Key.shadow: shadow
            ]
        )
        
        label.attributedText = attrText
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


//  MARK: - EXTENSION ATTRIBUTEDSTRING.KEY
public extension K.AttributedString.Key {
    
    func toNSAttributedStringKey() -> NSAttributedString.Key {
        switch self {
            case .font:
                return .font
            case .paragraphStyle:
                return .paragraphStyle
            case .foregroundColor:
                return .foregroundColor
            case .backgroundColor:
                return .backgroundColor
            case .ligature:
                return .ligature
            case .kern:
                return .kern
            case .tracking:
                return .tracking
            case .strikethroughStyle:
                return .strikethroughStyle
            case .underlineStyle:
                return .underlineStyle
            case .strokeColor:
                return .strokeColor
            case .strokeWidth:
                return .strokeWidth
            case .shadow:
                return .shadow
            case .textEffect:
                return .textEffect
            case .attachment:
                return .attachment
            case .link:
                return .link
            case .baselineOffset:
                return .baselineOffset
            case .underlineColor:
                return .underlineColor
            case .strikethroughColor:
                return .strikethroughColor
            case .writingDirection:
                return .writingDirection
        }
    }
    
}


