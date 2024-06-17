//  Created by Alessandro Comparini on 18/10/23.
//

import UIKit

@MainActor
open class SkeletonBuilder: Skeleton {
    
    private var skeletonGradient: GradientBuilder?
    private var skeletonLayerGradient: GradientBuilder?
    
    private var padding:(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) = (top: 0, left: 0, bottom: 0 , right: 0)
    private var transitionDuration: CGFloat?
    private var speed: K.Skeleton.SpeedAnimation?
    private var color: UIColor?
    private var radius: CGFloat?
    private var widthComponent: CGFloat?
    
//  MARK: - INITIALIZER
    private weak var component: BaseBuilder?
    
    public init(component: BaseBuilder) {
        self.component = component
        configure()
    }
    
    private lazy var skeletonView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setTop.equalTo(component?.baseView ?? UIView(), .top, padding.top)
                    .setLeading.equalTo(component?.baseView ?? UIView(), .leading, padding.left)
                    .setTrailing.equalTo(component?.baseView ?? UIView(), .trailing, -padding.right)
                    .setBottom.equalTo(component?.baseView ?? UIView(), .bottom, -padding.bottom)
            }
        return comp
    }()
    
    lazy var skeletonLayer: ViewBuilder = {
        let comp = ViewBuilder()
            .setTranslatesAutoresizingMaskIntoConstraints(false)
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
    public func setColorSkeleton(_ color: UIColor?) -> Self {
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
        setColorSkeleton(UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        padding = (top: top, left: left, bottom: bottom , right: right)
        return self
    }
    
    public func hideSkeleton() {
        stopAnimation()
    }


//  MARK: - SHOW SKELETON
    public func showSkeleton() {
        addSkeleton()
        configClipsToBoundsSkeletonView()
        configCustomCornerRadiusSkeletonView()
        configFrameSkeletonLayer()
        configGradient()
        startAnimation()
    }

    
//  MARK: - PRIVATE AREA
    private func configure() {
        setTransition(0.5)
    }

    private func configClipsToBoundsSkeletonView() {
        skeletonView.get.layer.masksToBounds = true
        skeletonView.get.clipsToBounds = true
    }
    
    private func addSkeleton() {
        addSkeletonView()
        addSkeletonLayer()
    }
    
    private func addSkeletonView() {
        guard let component else {return}
        skeletonView.add(insideTo: component.baseView.superview ?? UIView())
        skeletonView.applyConstraint()
    }
    
    private func addSkeletonLayer() {
        skeletonLayer.add(insideTo: skeletonView.get)
    }

    private func configCustomCornerRadiusSkeletonView() {
        guard let component else {return}
        skeletonView.get.layer.cornerRadius = component.baseView.layer.cornerRadius
        if let radius {
            skeletonView.setBorder { build in
                build.setCornerRadius(radius)
            }
        }
    }
    
    private func configGradient() {
        configGradientSkeletonView()
        configGradientSkeletonLayer()
    }
    
    private func configGradientSkeletonView() {
        let color: UIColor = color ?? .lightGray
        skeletonGradient = GradientBuilder(skeletonView.get)
            .setReferenceColor(color, percentageGradient: 10)
            .setOpacity(1)
            .apply()
    }
        
    private func configFrameSkeletonLayer() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            let widthLayer = calculateWidthSkeletonLayer()
            skeletonLayer.get.frame = CGRect(
                origin: CGPoint(x: -widthLayer, y: .zero),
                size: CGSize(width: widthLayer, height: skeletonView.get.bounds.height)
            )
        }
    }

    private func configGradientSkeletonLayer() {
        skeletonLayerGradient = GradientBuilder(skeletonLayer.get)
            .setGradientColors(configColorsGradientSkeleton())
            .setOpacity(0.8)
            .apply()
    }

    private func calculateWidthSkeletonLayer() -> CGFloat {
        let sixtySixPercent = 0.66
        return skeletonView.get.bounds.width * sixtySixPercent
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
        
        self.skeletonView.get.alpha = 1
        skeletonView.setHidden(false)
        let duration = TimeInterval(getDuration())
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            UIView.animate(withDuration: duration, delay: .zero, options: [.curveEaseInOut, .repeat], animations: { [weak self] in
                guard let self else {return}
                skeletonLayer.get.frame.origin.x = component?.baseView.layer.bounds.width ?? 100
            }, completion: nil)
        }
    }
    
    private func stopAnimation() {
        component?.setHidden(false)
        configWidthSkeletonView()
        if let transitionDuration {
            transitionDissolve(transitionDuration)
            return
        }
        remove()
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
    }
    
    private func transitionDissolve(_ transitionDuration: CGFloat) {
        UIView.animate(withDuration: transitionDuration, delay: .zero, animations: { [weak self] in
            self?.skeletonView.get.alpha = 0
        }, completion: { [weak self] _ in
            guard let self else {return}
            remove()
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

    private func remove() {
        skeletonLayer.get.layer.removeAllAnimations()
        skeletonView.get.layer.removeAllAnimations()
        skeletonView.setHidden(true)
        freeMemory()
    }
    
    private func freeMemory() {
//        component?.skeleton = nil
//        component?.gradient = nil
        skeletonLayerGradient = nil
        skeletonGradient = nil
    }
    
}
