//  Created by Alessandro Comparini on 19/12/23.
//

import UIKit

public class BlurBuilder: Blur {
    
    private var vibrancyView: UIVisualEffectView?
    private var opacity: CGFloat = 0.98
    
    
//  MARK: - INITIALIZERS
    
    private weak var component: UIView!
    private var blurEffect: UIBlurEffect
    
    public init(_ component: UIView, style: UIBlurEffect.Style) {
        self.component = component
        self.blurEffect = UIBlurEffect(style: style)
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
    
    
//  MARK: - APPLY BLUR
    @discardableResult
    public func apply() -> Self {
        configBlur()
        print("teste")
        return self
    }
    
//  MARK: - Private Function Area
    
    private func configure() {
        configBackgroundColor()
    }
        
    private func configBackgroundColor() {
        component?.backgroundColor = .clear
    }
    
    private func configBlur() {
        addBlurOnComponent()
        configConstraintsBlurView()
        configAutoresizingMask()
        configAlphaBlur()
    }
    
    private func addBlurOnComponent () {
        component?.addSubview(blurVisualEffectView)
    }
    
    private func configConstraintsBlurView() {
        self.blurVisualEffectView.makeConstraints({ make in
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
