//  Created by Alessandro Comparini on 19/12/23.
//

import UIKit

public class BlurBuilder: BaseBuilder, Blur {
    public typealias T = UIVisualEffectView
    
    private var vibrancyView: UIVisualEffectView?
    private var opacity: CGFloat = 1
    
    private var blur: UIVisualEffectView
        
    public var get: UIVisualEffectView { blur }
    
    
//  MARK: - INITIALIZERS
    
    private var blurEffect: UIBlurEffect
    
    public init(style: UIBlurEffect.Style) {
        self.blurEffect = UIBlurEffect(style: style)
        self.blur = UIVisualEffectView(effect: self.blurEffect)
        super.init(blur)
        configure()
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setOpacity(_ opacity: CGFloat) -> Self {
        self.opacity = opacity
        return self
    }
    
    
//  MARK: - Private Function Area
    
    private func configure() {
        configBackgroundColor()
        configAutoresizingMask()
        configAlphaBlur()
    }

    private func configBackgroundColor() {
        blur.setBackgroundColor(.clear)
    }

    private func configAutoresizingMask() {
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func configAlphaBlur() {
        blur.alpha = self.opacity
    }
    
}
