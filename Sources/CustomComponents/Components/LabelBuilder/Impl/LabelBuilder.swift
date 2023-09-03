
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
        setColor(hexColor)
    }
    
    public convenience init(_ text: String, _ hexColor: String, _ aligment: Constants.TextAlignment) {
        self.init(text, hexColor)
        setTextAlignment(aligment)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    public func setBackgroundColor(_ hexColor: String) -> Self {
        label.backgroundColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setTextAlignment(_ textAlignment: Constants.TextAlignment) -> Self {
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
    public func setWeight(_ weight: Constants.Weight) -> Self {
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: weight.toFontWeight() )
        return self
    }
    
        
}


//  MARK: - EXTENSION WEIGHT
extension Constants.Weight {
    
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
