//  Created by Alessandro Comparini on 18/10/23.
//

import UIKit

import SkeletonView

open class SkeletonBuilderCopy: BaseBuilder, SkeletonCopy {
    
    private var color: UIColor?
    
    init(component: UIView) {
        super.init(component)
        configure()
    }
    
    
    
    
//    
//    private func configSkeleton() {
//        let skeleton = ViewBuilder()
//            .setBackgroundColor(color: .lightGray)
//            .setConstraints { build in
//                build
//                    .setAlignmentCenterXY.equalToSafeArea
//                    .setWidth.equalToConstant(250)
//                    .setHeight.equalToConstant(50)
//            }
//
//        skeleton.add(insideTo: self)
//        skeleton.applyConstraint()
//
//        let skeletonLayer = UIView(frame: CGRect(origin: CGPoint(x: -50, y: 0), size: CGSize(width: 50, height: 50)))
//        skeletonLayer.backgroundColor = UIColor.black.withAlphaComponent(0.05)
//        skeletonLayer.clipsToBounds = true
//        skeleton.get.layer.masksToBounds = true
//        skeleton.get.addSubview(skeletonLayer)
//
//
//        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveLinear, .repeat], animations: { [self] in
//            skeletonLayer.frame.origin.x = 250
//        }, completion: nil)
//        
//    }
//    

    
    
    
    
    
    
    
    
    
    
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setIsSkeletonable(_ flag: Bool) -> Self {
        super.baseView.isSkeletonable = flag
        super.baseView.isUserInteractionDisabledWhenSkeletonIsActive = flag
        return self
    }
    
    @discardableResult
    public func setColorSkeleton(color: UIColor) -> Self {
        self.color = color
        return self
    }
    
    @discardableResult
    public func setColorSkeleton(hexColor: String?) -> Self {
        guard let hexColor, hexColor.isHexColor() else {return self}
        setColorSkeleton(color: UIColor.HEX(hexColor))
        return self
    }

    @discardableResult
    public func setLastLineFillPercent(_ percent: Int) -> Self {
        if super.baseView.isKind(of: UILabel.self) {
            (super.baseView as? UILabel)?.lastLineFillPercent = percent
        }
        if super.baseView.isKind(of: UITextView.self) {
            (super.baseView as? UITextView)?.lastLineFillPercent = percent
        }
        SkeletonAppearance.default.multilineLastLineFillPercent = percent
        return self
    }
    
    @discardableResult
    public func setLinesCornerRadius(_ radius: Int) -> Self {
        if super.baseView.isKind(of: UILabel.self) {
            (super.baseView as? UILabel)?.linesCornerRadius = radius
        }
        if super.baseView.isKind(of: UITextView.self) {
            (super.baseView as? UITextView)?.linesCornerRadius = radius
        }
        SkeletonAppearance.default.multilineCornerRadius = radius
        return self
    }
    
    @discardableResult
    public func setSkeletonLineSpacing(_ spacing: CGFloat) -> Self {
        SkeletonAppearance.default.multilineSpacing = spacing
        return self
    }
    
    @discardableResult
    public func setSkeletonCornerRadius(_ radius: Float) -> Self {
        baseView.skeletonCornerRadius = radius
        return self
    }

    @discardableResult
    public func showSkeleton(_ displayTypes: DisplayTypes) -> Self {
        switch displayTypes {
            case .solid:
                configShow()
                
            case .gradient:
                configShowGradient()
                
            case .solidAnimated:
                configShowSolidAnimated()
                
            case .gradientAnimated:
                configShowGrandientAnimated()
        }
        
        return self
    }
    
    public func hideSkeleton() {
        super.baseView.hideSkeleton(transition: .crossDissolve(0.5))
    }

    
//  MARK: - PRIVATE AREA
   
    private func configure() {
        setIsSkeletonable(true)
        setColorSkeleton(color: .lightGray)
    }
    
    private func configShow() {
        if let color {
            super.baseView.showSkeleton(usingColor: color)
            return
        }
        super.baseView.showSkeleton()
    }
    
    private func configShowGradient() {
        if let color {
            let skeletonGradient = SkeletonGradient(baseColor: color)
            super.baseView.showGradientSkeleton(usingGradient: skeletonGradient)
            return
        }
        super.baseView.showGradientSkeleton()
    }
    
    private func configShowSolidAnimated() {
        if let color {
            super.baseView.showAnimatedSkeleton(usingColor: color, animation: nil, transition: .crossDissolve(0.5))
            return
        }
        super.baseView.showAnimatedSkeleton(transition: .crossDissolve(0.5))
    }
    
    private func configShowGrandientAnimated() {
        if let color {
            let skeletonGradient = SkeletonGradient(baseColor: color)
            baseView.showAnimatedGradientSkeleton(usingGradient: skeletonGradient, animation: nil, transition: .crossDissolve(0.5))
            return
        }
        baseView.showAnimatedGradientSkeleton(transition: .crossDissolve(0.5))   
    }
    
    
}