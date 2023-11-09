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
    
    private lazy var skeletonView: SkeletonView = {
        let comp = SkeletonView()
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
        self.color = color
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
        
        let color = color ?? .lightGray
        print("entrou")
        
        skeletonView.add(insideTo: component)
        
        skeletonView
            .setGradient { build in
                build
                    .setReferenceColor(color, percentageGradient: 10)
                    .setOpacity(1)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setPin.equalTo(component)
                    .apply()
            }
    }
    
    private func configGradientOfSkeletonLayer() {
        skeletonView.skeletonLayer
            .setGradient { build in
                build
                    .setGradientColors(configColorsGradientSkeleton())
                    .setOpacity(0.8)
                    .apply()
            }
        skeletonView.skeletonLayer.setConstraints { build in
            build
                .setWidth.equalToConstant(100)
        }
    }
    
    private func configColorsGradientSkeleton() -> [UIColor] {
        let color = color ?? .lightGray
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
        animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut, animations: { [weak self] in
            guard let self, let widthComponent else {return}
            skeletonView.skeletonLayer.get.frame.origin.x = widthComponent
        })
        animator?.startAnimation()
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
