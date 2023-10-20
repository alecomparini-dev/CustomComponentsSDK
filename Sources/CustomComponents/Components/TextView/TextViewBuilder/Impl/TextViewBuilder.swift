//  Created by Alessandro Comparini on 11/10/23.
//

import UIKit

open class TextViewBuilder: BaseBuilder, TextView {
    public typealias T = UITextView
    public var get: UITextView { self.textView}
    
    private var fontSize: CGFloat?
    private var paragraphStyle = NSMutableParagraphStyle()
    
    private var textView: UITextView
    
    public init() {
        self.textView = UITextView()
        super.init(textView)
        configure()
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setInsertText(_ text: String) -> Self {
        textView.insertText(text)
        let attributedText = NSAttributedString(string: textView.text, attributes: [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: fontSize ?? 14)
        ])
        textView.attributedText = attributedText
        return self
    }
    
    @discardableResult
    public func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self {
        guard let textAlignment else {return self}
        textView.textAlignment = NSTextAlignment.init(rawValue: textAlignment.rawValue) ?? .left
        return self
    }
    
    @discardableResult
    public func setTextColor(color: UIColor?) -> Self {
        guard let color else {return self}
        textView.textColor = color
        return self
    }
    
    @discardableResult
    public func setTextColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTextColor(color: UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self {
        guard let fontFamily else {return self}
        if let font = UIFont(name: fontFamily, size: fontSize ?? K.Default.fontSize) {
            textView.font = font
        }
        return self
    }
    
    @discardableResult
    public func setSize(_ fontSize: CGFloat) -> Self {
        self.fontSize = fontSize
        let attributedText = NSAttributedString(string: textView.text, attributes: [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: fontSize)
        ])
        textView.attributedText = attributedText
        return self
    }
    
    @discardableResult
    public func setLineSpacing(_ spacing: CGFloat) -> Self {
        paragraphStyle.lineSpacing = spacing
        return self
    }
    
    @discardableResult
    public func setPadding(left: CGFloat? = nil, top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil) -> Self {
        if let left { textView.textContainerInset.left = left }
        if let top { textView.textContainerInset.top = top }
        if let right { textView.textContainerInset.right = right}
        if let bottom { textView.textContainerInset.bottom = bottom }
        return self
    }
    
    @discardableResult
    public func setReadOnly(_ flag: Bool) -> Self {
        textView.isEditable = !flag
        return self
    }
    
    @discardableResult
    public func setClearText() -> Self {
        textView.text = ""
        return self
    }
    
    @discardableResult
    public func setText(_ text: String) -> Self {
        textView.text = text
        return self
    }


    
//  MARK: - PRIVATE AREA
    private func configure() {
        setLineSpacing(5)
        setPadding(top: 12)
    }
    
}
