//  Created by Alessandro Comparini on 18/10/23.
//

import UIKit


open class SkeletonBuilder: Skeleton {

    private var animator: UIViewPropertyAnimator?
    private var speed: K.Skeleton.SpeedAnimation?
    private var color: UIColor?
    private var widthComponent: CGFloat?
    
    private weak var component: UIView?
    
    public init(component: UIView) {
        self.component = component
        configure()
    }
    
    private lazy var skeletonView: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    lazy var skeletonLayer: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    
//  MARK: - SET PROPERTIES

    @discardableResult
    public func setSpeedAnimation(_ speed: K.Skeleton.SpeedAnimation) -> Self {
        self.speed = speed
        return self
    }
    
    @discardableResult
    public func setColorSkeleton(color: UIColor?) -> Self {
//        self.color = color
        self.color = .lightGray
        return self
    }
    
    @discardableResult
    public func setColorSkeleton(hexColor: String?) -> Self {
        guard let hexColor, hexColor.isHexColor() else {return self}
        setColorSkeleton(color: UIColor.HEX(hexColor))
        return self
    }
    
    public func hideSkeleton(_ completion: completion?) {
        animator?.stopAnimation(true)
        animator = nil
    }


//  MARK: - APPLY SKELETON
    @discardableResult
    public func apply() -> Self {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            configGradientSkeleton()
            configGradientOfSkeletonLayer()
            startAnimation()
        }
        
        return self
    }

    
//  MARK: - PRIVATE AREA
   
    private func configure() {

    }
    
    private func configGradientSkeleton() {
        guard let component else {return}
        
        let color: UIColor = color ?? .lightGray
        
        skeletonView.get.frame = component.bounds
        skeletonView.get.layer.cornerRadius = component.layer.cornerRadius
        
        skeletonView.add(insideTo: component.superview ?? component)
        skeletonView.setConstraints { build in
            build
                .setPin.equalTo(component)
                .apply()
        }
        
        skeletonView
            .setGradient { build in
                build
                    .setReferenceColor(color, percentageGradient: 10)
                    .setOpacity(1)
                    .apply()
            }
        
        skeletonView.get.layer.masksToBounds = true
    }
    
    private func configGradientOfSkeletonLayer() {
        
        skeletonLayer = ViewBuilder(frame: 
                                        CGRect(
                                            origin: CGPoint(x: -100, y: 0),
                                            size: CGSize(width: 100, height: skeletonView.get.bounds.height)
                                        ))
        
        skeletonLayer.add(insideTo: skeletonView.get)
        
        skeletonLayer
            .setGradient { build in
                build
                    .setGradientColors(configColorsGradientSkeleton())
                    .setOpacity(1)
                    .apply()
            }
        
    }
    
    private func configColorsGradientSkeleton() -> [UIColor] {
        let color: UIColor = color ?? .lightGray
        let color1 = color.adjustBrightness(5).withAlphaComponent(0.8)
        let color2 = color.adjustBrightness(15)
        let color3 = color.adjustBrightness(25)
        let color4 = color.adjustBrightness(25)
        let color5 = color.adjustBrightness(15)
        let color6 = color.adjustBrightness(5).withAlphaComponent(0.8)
        return [color1, color2, color3, color4, color5, color6 ]
    }
    
    private func startAnimation() {
        let duration = TimeInterval(getDuration())
        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseInOut, .repeat], animations: { [weak self] in
            guard let self else {return}
            skeletonLayer.get.frame.origin.x = 350
        }, completion: nil)
        
    }
    
    private func getDuration() -> Float {
        switch speed {
            case .slow:
                return 1
            case .medium:
                return 1.5
            case .fast:
                return 2.5
            case nil:
                return 1.5
        }
    }
    
}
