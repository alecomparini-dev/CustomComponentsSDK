//  Created by Alessandro Comparini on 02/09/23.
//

import UIKit

open class ButtonBuilder: BaseBuilder, Button {
    public typealias T = UIButton
    public var get: UIButton {self.button}
    
    private var button: UIButton
    
    public init() {
        self.button = UIButton(type: .system)
        super.init(button)
    }
    
    public convenience init(_ title: String) {
        self.init()
        self.setTitle(title)
    }
        
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setTitle(_ title: String?) -> Self {
        guard let title else {return self}
        button.setTitle(title, for: .normal)
        return self
    }
    
    @discardableResult
    public func setTitleColor(hexColor: String?) -> Self {
        guard let hexColor else {return self}
        button.setTitleColor(UIColor.HEX(hexColor), for: .normal)
        button.setTitleColor(UIColor.HEX(hexColor).withAlphaComponent(0.7), for: .disabled)
        return self
    }
    
    @discardableResult
    public func setTintColor(hexColor: String?) -> Self {
        guard let hexColor else {return self}
        button.tintColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setTextAlignment(_ textAlignment: K.Text.Alignment?) -> Self {
        guard let textAlignment else {return self}
        button.titleLabel?.textAlignment = NSTextAlignment.init(rawValue: textAlignment.rawValue) ?? .center
        return self
    }
    
    @discardableResult
    public func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self {
        guard let fontFamily else {return self}
        button.titleLabel?.font = UIFont(name: fontFamily, size: fontSize ?? K.Default.fontSize)
        return self
    }
    
    @discardableResult
    public func setTitleSize(_ fontSize: CGFloat?) -> Self {
        guard let fontSize else {return self}
        button.titleLabel?.font = button.titleLabel?.font.withSize(fontSize)
        return self
    }
    
    @discardableResult
    public func setTitleWeight(_ weight: K.Weight?) -> Self {
        guard let weight else {return self}
        if let titleLabelFont = button.titleLabel?.font {
            button.titleLabel?.font = UIFont.systemFont(ofSize: titleLabelFont.pointSize, weight: weight.toFontWeight() )
        }
        return self
    }
    
    
}
