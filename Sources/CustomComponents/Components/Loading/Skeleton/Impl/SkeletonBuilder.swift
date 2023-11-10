//  Created by Alessandro Comparini on 18/10/23.
//

import UIKit


open class SkeletonBuilder: Skeleton {
    
    private var skeletonGradient: GradientBuilder?
    private var skeletonLayerGradient: GradientBuilder?
    
    private var transitionDuration: CGFloat?
    private var speed: K.Skeleton.SpeedAnimation?
    private var color: UIColor?
    private var radius: CGFloat?
    private var widthComponent: CGFloat?
    
    private weak var component: BaseBuilder?
    
    public init(component: BaseBuilder) {
        self.component = component
        configure()
    }
    
    private lazy var skeletonView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setPin.equalTo(component?.baseView ?? UIView())
            }
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
    public func setTransition(_ duration: CGFloat) -> Self {
        transitionDuration = duration
        return self
    }
    
    @discardableResult
    public func setColorSkeleton(color: UIColor?) -> Self {
        self.color = color
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ radius: CGFloat) -> Self {
        self.radius = radius
        return self
    }
    
    @discardableResult
    public func setColorSkeleton(hexColor: String?) -> Self {
        guard let hexColor, hexColor.isHexColor() else {return self}
        setColorSkeleton(color: UIColor.HEX(hexColor))
        return self
    }
    
    public func hideSkeleton() {
        stopAnimation()
    }


//  MARK: - APPLY SKELETON
    @discardableResult
    public func apply() -> Self {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            configSkeletonView()
            configSkeletonLayer()
            configClipsToBounds()
            startAnimation()
        }
        return self
    }

    
//  MARK: - PRIVATE AREA
    private func configure() {
        setTransition(0.5)
    }

    private func configClipsToBounds() {
        skeletonView.get.layer.masksToBounds = false
        skeletonView.get.clipsToBounds = false
        skeletonLayer.get.layer.masksToBounds = false
        skeletonLayer.get.clipsToBounds = false
    }
    
    private func configSkeletonView() {
        addSkeletonOnComponent()
        configCustomCornerRadius()
        configGradientSkeletonView()
    }

    private func addSkeletonOnComponent() {
        guard let component else {return}
        skeletonView.add(insideTo: component.baseView.superview ?? UIView())
        skeletonView.get.bounds = component.baseView.layer.bounds
        skeletonView.applyConstraint()
    }
    
    private func configCustomCornerRadius() {
        guard let component else {return}
        skeletonView.get.layer.cornerRadius = component.baseView.layer.cornerRadius
        if let radius {
            skeletonView.setBorder { build in
                build.setCornerRadius(radius)
            }
        }
    }
    
    private func configGradientSkeletonView() {
        let color: UIColor = color ?? .lightGray
        skeletonGradient = GradientBuilder(skeletonView.get)
            .setReferenceColor(color, percentageGradient: 10)
            .setOpacity(1)
            .apply()
    }
    
    private func configSkeletonLayer() {
        configFrameSkeletonLayer()
        configGradientSkeletonLayer()
    }

    private func configFrameSkeletonLayer() {
       
        let startLayer = calculateStartLayer()
        skeletonLayer.add(insideTo: skeletonView.get)
        configClipsToBounds()
        
        skeletonLayer.get.frame = CGRect(
            origin: CGPoint(x: -startLayer, y: .zero),
            size: CGSize(width: startLayer, height: skeletonView.get.bounds.height)
        )
        skeletonLayer.get.layersResizeIfNeeded()
        
    }

    private func calculateStartLayer() -> CGFloat {
        guard let component else {return .zero}
        return (component.baseView.layer.bounds.width * 66)/100
    }
    
    private func configGradientSkeletonLayer() {
        skeletonLayerGradient = GradientBuilder(skeletonLayer.get)
            .setGradientColors(configColorsGradientSkeleton())
            .setOpacity(0.8)
            .apply()
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
        component?.setHidden(true)
        let duration = TimeInterval(getDuration())
        UIView.animate(withDuration: duration, delay: .zero, options: [.curveEaseInOut, .repeat], animations: { [weak self] in
            guard let self else {return}
            skeletonLayer.get.frame.origin.x = component?.baseView.layer.bounds.width ?? 100
        }, completion: nil)
    }
    
    private func stopAnimation() {
        component?.setHidden(false)
        configWidthSkeletonView()
        if let transitionDuration {
            transitionDissolve(transitionDuration)
            return
        }
        hide()
    }
    
    private func configWidthSkeletonView() {
        guard let component else {return}
        component.baseView.layoutIfNeeded()
        skeletonView.get.layer.frame = CGRect(
            origin: CGPoint(
                x: skeletonView.get.layer.frame.origin.x,
                y: skeletonView.get.layer.frame.origin.y),
            size: CGSize(
                width: component.baseView.layer.frame.width,
                height: skeletonView.get.layer.frame.height))

        skeletonView.get.layersResizeIfNeeded()
    }
    
    private func transitionDissolve(_ transitionDuration: CGFloat) {
        UIView.animate(withDuration: transitionDuration, delay: .zero, animations: { [weak self] in
            self?.skeletonView.get.alpha = 0
        }, completion: { [weak self] _ in
            guard let self else {return}
            hide()
        })
    }

    private func getDuration() -> Float {
        switch speed {
            case .slow:
                return 2.5
            case .medium:
                return 1.5
            case .fast:
                return 1
            case nil:
                return 1.5
        }
    }

    private func hide() {
        skeletonLayer.get.layer.removeAllAnimations()
        skeletonView.get.layer.removeAllAnimations()
        skeletonView.get.removeFromSuperview()
        freeMemory()
    }
    
    private func freeMemory() {
        component?.skeleton = nil
        component?.gradient = nil
        skeletonLayerGradient = nil
        skeletonGradient = nil
    }
    
}
