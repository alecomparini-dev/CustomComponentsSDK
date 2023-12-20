//  Created by Alessandro Comparini on 19/12/23.
//

import UIKit

public class BlurBuilder: BaseBuilder, Blur {
    
    private var vibrancyView: UIVisualEffectView?
    private var opacity: CGFloat = 0.98
    
    private var blur: ViewBuilder
        
    public var get: ViewBuilder { blur }
    
    
//  MARK: - INITIALIZERS
    
    private var blurEffect: UIBlurEffect
    
    public init(style: UIBlurEffect.Style) {
        self.blurEffect = UIBlurEffect(style: style)
        self.blur = ViewBuilder()
        super.init(blur.get)
        configure()
    }
    
    
//  MARK: - LAZY AREA
    lazy var blurVisualEffectView: UIVisualEffectView = {
        let comp = UIVisualEffectView(effect: self.blurEffect)
        return comp
    }()
    
    
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
    }

    private func configBackgroundColor() {
        blur.setBackgroundColor(.clear)
    }
   
    private func addBlurOnComponent () {
        blurVisualEffectView.contentView.addSubview(blur.get)
    }
    
    private func configConstraintsBlurView() {
        self.blurVisualEffectView.contentView.makeConstraints({ make in
            make
                .setPin.equalToSuperView
                .apply()
        })
    }
    
    private func configAutoresizingMask() {
        blurVisualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func configAlphaBlur() {
        blurVisualEffectView.alpha = self.opacity
    }
    
}
