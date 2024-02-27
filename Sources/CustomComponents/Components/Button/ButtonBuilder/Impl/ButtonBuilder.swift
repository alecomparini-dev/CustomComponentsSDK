//  Created by Alessandro Comparini on 02/09/23.
//

import UIKit


open class ButtonBuilder: BaseBuilder, Button {
    public typealias T = UIButton
    public var get: UIButton {self.button}
    
    private var loading: LoadingBuilder?
    private var titleButton: String?
    private var titleWeight: UIFont.Weight = .regular
    
    private var button: UIButton

    
//  MARK: - INITIALIZERS

    public init() {
        self.button = UIButton(type: .system)
        super.init(button)
        configure()
    }
    
    public init(_ title: String) {
        self.button = UIButton(type: .system)
        super.init(button)
        self.setTitle(title)
        configure()
    }
        
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setTitle(_ title: String?) -> Self {
        guard let title else {return self}
        button.setTitle(title, for: .normal)
        return self
    }
    
    @discardableResult
    public func setTitleColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        button.setTitleColor(color, for: .normal)
        button.setTitleColor(color.withAlphaComponent(0.7), for: .disabled)
        return self
    }
    
    @discardableResult
    public func setTitleColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTitleColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setTitleColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setTitleColor(namedColor)
        return self
    }
    
    @discardableResult
    public func setTintColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        button.tintColor = color
        return self
    }
    
    @discardableResult
    public func setTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTintColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setTintColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setTintColor(namedColor)
        return self
    }
    
    @discardableResult
    public func setTitleAlignment(_ textAlignment: K.Text.ContentHorizontalAlignment?) -> Self {
        guard let textAlignment else {return self}
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment(rawValue: textAlignment.rawValue) ?? .center
        return self
    }
    
    @discardableResult
    public func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat?) -> Self {
        guard let fontFamily else {return self}
        if let font = UIFont(name: fontFamily, size: fontSize ?? K.Default.fontSize) {
            button.titleLabel?.font = font
        }
        return self
    }
    
    @discardableResult
    public func setItalicFont() -> Self {
        if let currentFont = button.titleLabel?.font {
            let descriptor = currentFont.fontDescriptor
            let descriptorWithTraits = descriptor.withSymbolicTraits([.traitBold, .traitItalic])!
            button.titleLabel?.font = UIFont(descriptor: descriptorWithTraits, size: button.titleLabel?.font.pointSize ?? K.Default.fontSize)
        }
        return self
    }
    
    @discardableResult
    public func setTitleSize(_ fontSize: CGFloat?) -> Self {
        guard let fontSize else {return self}
        if #available(iOS 15.0, *) {
            setTitleSize(configuration: fontSize)
            return self
        }
        if let font = button.titleLabel?.font.withSize(fontSize) {
            button.titleLabel?.font = font
        }
        return self
    }
    
    @discardableResult
    public func setTitleWeight(_ weight: K.Weight?) -> Self {
        guard let weight else {return self}
        self.titleWeight = weight.toFontWeight()
        if #available(iOS 15.0, *) {
            setTitleWeight(configuration: weight)
            return self
        }
        if let titleLabelFont = button.titleLabel?.font {
            button.titleLabel?.font = UIFont.systemFont(ofSize: titleLabelFont.pointSize, weight: weight.toFontWeight() )
        }
        return self
    }

    @discardableResult
    public func setShowLoadingIndicator(_ styleIndicator: K.ActivityIndicator.Style = .medium) -> Self {
        self.loading = LoadingBuilder()
            .setStyle(styleIndicator)
            .setColor(.darkGray)
            .setHideWhenStopped(true)
        configLoadingIndicator()
        return self
    }

    @discardableResult
    public func setShowLoadingIndicator(_ build: (_ build: LoadingBuilder) -> LoadingBuilder) -> Self {
        self.loading = build(LoadingBuilder())
        configLoadingIndicator()
        return self
    }
    
    @discardableResult
    public func setHideLoadingIndicator() -> Self {
        if let loading {
            loading.setStopAnimating()
            button.setTitle(self.titleButton, for: .normal)
        }
        loading = nil
        titleButton = nil
        return self
    }
    
    @discardableResult
    public func setFloatButton() -> Self {
        self.button.layer.zPosition = K.Button.hierarchyFloatButton
        bringToFront()
        return self
    }
    
    
    @discardableResult
    public func setFrame(_ frame: CGRect) -> Self {
        self.button.frame = frame
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        if #available(iOS 15.0, *) {
            button.configuration = UIButton.Configuration.plain()
        }
    }
    
    private func configLoadingIndicator() {
        if let loading {
            loading.add(insideTo: button)
            loading.setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSafeArea
                    .apply()
            }
            loading.setStartAnimating()
            self.titleButton = button.currentTitle
            button.setTitle("", for: .normal)
        }
    }

    private func bringToFront() {
        guard let superview = self.button.superview else {return}
        superview.bringSubviewToFront(self.button)
    }
    
    @available(iOS 15.0, *)
    private func setTitleSize(configuration fontSize: CGFloat?) {
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [weak self] attrTransformer in
            var attr = attrTransformer
            attr.font = .systemFont(ofSize: fontSize ?? .zero , weight: self?.titleWeight ?? .regular)
            return attr
        }
    }

    @available(iOS 15.0, *)
    private func setTitleWeight(configuration weight: K.Weight?) {
        let fontSize = self.button.titleLabel?.font.pointSize
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [weak self] attrTransformer in
            var attr = attrTransformer
            attr.font = UIFont.systemFont(ofSize: fontSize ?? .zero, weight: self?.titleWeight ?? .regular)
            return attr
        }
    }
    
}
