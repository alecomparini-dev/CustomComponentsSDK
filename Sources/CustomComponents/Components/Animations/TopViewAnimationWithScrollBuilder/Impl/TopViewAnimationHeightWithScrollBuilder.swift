//  Created by Alessandro Comparini on 26/02/24.
//

import UIKit

public class TopViewAnimationHeightWithScrollBuilder: ViewBuilder, TopViewAnimationHeightWithScroll {
    public typealias T = UIScrollView
    
    private var initialOffset: CGFloat?
    private var lastContentOffset: CGFloat = 0.0
    private var heightChange: TopViewAnimationHeightWithScrollBuilder.HeightChange = .increasing
    private var heightAnchor: NSLayoutConstraint?
    private var scrollView: UIScrollView!
    
    public enum HeightChange {
        case increasing
        case decreasing
    }
    
    
//  MARK: - INITIALIZERS
    
    private let height: (ini: CGFloat, end: CGFloat)
    
    public init(height: (ini: CGFloat, end: CGFloat)) {
        self.height = height
        super.init()
        configure()
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setView(_ viewBuilder: ViewBuilder) -> Self {
        viewBuilder.add(insideTo: self.get)
        viewBuilder.setConstraints { build in
            build
                .setPin.equalToSuperView
                .apply()
        }
        return self
    }
    
    @discardableResult
    public func setAnimation(_ heightChange: TopViewAnimationHeightWithScrollBuilder.HeightChange) -> Self {
        self.heightChange = heightChange
        return self
    }
    
    
//  MARK: - START
    public func animation(_ scrollView: UIScrollView) {
        setInitialOffSet(scrollView)
        
        guard let initialOffset else {return}
        
        let currentOffset = scrollView.contentOffset.y
        
        let animationInit: CGFloat = height.ini
        let animationFinal: CGFloat = -(abs(height.end))
        
        let animationThreshold: CGFloat = animationInit - animationFinal
        
        let scrolling = (currentOffset - initialOffset)
        let completed = (scrolling/animationThreshold)
        
        if scrolling > 0 {
            heightAnchor?.constant = min((animationThreshold)*completed, animationThreshold)
        } else {
            heightAnchor?.constant = animationInit
        }
        
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configBackgroundColor()
        configHeightAnchor()
    }
    
    private func setInitialOffSet(_ scrollView: UIScrollView) {
        if initialOffset == nil {
            initialOffset = scrollView.contentOffset.y
        }
    }
    
    private func configBackgroundColor() {
        self.setBackgroundColor(.clear)
    }
    
    private func configHeightAnchor() {
//        heightAnchor = NSLayoutConstraint(item: self.get,
//                                          attribute: .height,
//                                          relatedBy: .equal,
//                                          toItem: nil,
//                                          attribute: .height,
//                                          multiplier: 1,
//                                          constant: height.ini)
        heightAnchor = self.get.constraints.first(where: { $0.firstAttribute == .height })
    }
    
    
    
    
}
