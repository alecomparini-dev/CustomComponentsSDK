//  Created by Alessandro Comparini on 19/12/23.
//

import UIKit

public class BlurBuilder: BaseBuilder, Blur {
    
    private var vibrancyView: UIVisualEffectView?
    private var opacity: CGFloat = 1
    
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
        configVibrancyEffect()
    }

    private func configBackgroundColor() {
        blur.setBackgroundColor(.clear)
    }
   
    private func addBlurOnComponent () {
        blur.get.addSubview(blurVisualEffectView)
    }
    
    private func configConstraintsBlurView() {
        self.blurVisualEffectView.makeConstraints({ make in
            make
                .setPin.equalTo(blur.get)
                .apply()
        })
    }
    
    private func configVibrancyEffect() {
        // Adicione vibrancy ao efeito de desfoque
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        
        let label = UILabel()
        label.text = "Alguma coisa"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24)
        
        // Adicione a label à sua view
        blur.get.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: blur.get.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: blur.get.centerYAnchor)
        ])
        
        vibrancyEffectView.contentView.addSubview(label)
        blurVisualEffectView.contentView.addSubview(vibrancyEffectView)
        vibrancyEffectView.makeConstraints({ make in
            make
                .setPin.equalTo(blur.get)
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
