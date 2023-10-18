//  Created by Alessandro Comparini on 18/10/23.
//

import UIKit

import SkeletonView

open class SkeletonBuilder: BaseBuilder, Skeleton {
    
    private var color: UIColor?
       
    init(component: UIView) {
        super.init(component)
    }
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setIsSkeletonable(_ flag: Bool) -> Self {
        super.baseView.isSkeletonable = flag
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
    
    public func showSkeleton(_ displayTypes: DisplayTypes) {
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
    }
    
    public func hideSkeleton() {
        
    }

    
//  MARK: - PRIVATE AREA
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
            super.baseView.showAnimatedSkeleton(usingColor: color)
            return
        }
        super.baseView.showAnimatedSkeleton()
    }
    
    private func configShowGrandientAnimated() {
        if let color {
            let skeletonGradient = SkeletonGradient(baseColor: color)
            super.baseView.showAnimatedGradientSkeleton(usingGradient: skeletonGradient)
            return
        }
        super.baseView.showAnimatedGradientSkeleton()
    }
    
    
}
