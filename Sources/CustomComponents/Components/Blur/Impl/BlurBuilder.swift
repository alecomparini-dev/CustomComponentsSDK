//  Created by Alessandro Comparini on 19/12/23.
//

import UIKit

public class BlurBuilder: ViewBuilder, Blur {
    public typealias T = UIVisualEffectView
    
    private var vibrancyView: UIVisualEffectView?
    private var opacity: CGFloat = 1
    
    private var blur: UIVisualEffectView
        
    
//  MARK: - INITIALIZERS
    
    private var blurEffect: UIBlurEffect
    
    public init(style: UIBlurEffect.Style) {
        self.blurEffect = UIBlurEffect(style: style)
        self.blur = UIVisualEffectView(effect: self.blurEffect)
        super.init()
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
        addBlurOnComponent()
        configConstraintsBlurView()
        configAutoresizingMask()
        configAlphaBlur()
        removeInteraction()
    }

    private func configBackgroundColor() {
        self.setBackgroundColor(.clear)
        blur.setBackgroundColor(.clear)
    }
    
    private func addBlurOnComponent() {
        self.get.addSubview(blur)
    }
    
    private func configConstraintsBlurView() {
        self.blur.makeConstraints({ make in
            make
                .setPin.equalToSuperView
                .apply()
        })
    }
    
    private func removeInteraction() {
        blur.isUserInteractionEnabled = false
    }

    private func configAutoresizingMask() {
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func configAlphaBlur() {
        blur.alpha = self.opacity
    }
    
}
