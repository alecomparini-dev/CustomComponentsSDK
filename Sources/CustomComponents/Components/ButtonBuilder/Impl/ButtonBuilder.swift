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
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setTitle(_ title: String) -> Self {
        button.setTitle(title, for: .normal)
        return self
    }
    
    @discardableResult
    public func setTitleColor(_ hexColor: String) -> Self {
        button.setTitleColor(UIColor.HEX(hexColor), for: .normal)
        button.setTitleColor(UIColor.HEX(hexColor).withAlphaComponent(0.7), for: .disabled)
        return self
    }
    
    @discardableResult
    public func setTintColor(_ hexColor: String) -> Self {
        button.tintColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setTextAlignment(_ textAlignment: Constants.TextAlignment) -> Self {
        button.titleLabel?.textAlignment = NSTextAlignment.init(rawValue: textAlignment.rawValue) ?? .center
        return self
    }
    
    @discardableResult
    public func setFontFamily(_ fontFamily: String, _ fontSize: CGFloat) -> Self {
        button.titleLabel?.font = UIFont(name: fontFamily, size: fontSize)
        return self
    }
    
    @discardableResult
    public func setTitleSize(_ fontSize: CGFloat) -> Self {
        button.titleLabel?.font = button.titleLabel?.font.withSize(fontSize)
        return self
    }
    
    @discardableResult
    public func setTitleWeight(_ weight: Constants.Weight) -> Self {
        if let titleLabelFont = button.titleLabel?.font {
            button.titleLabel?.font = UIFont.systemFont(ofSize: titleLabelFont.pointSize, weight: weight.toFontWeight() )
        }
        return self
    }
    
    
}
