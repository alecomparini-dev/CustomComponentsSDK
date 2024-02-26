//  Created by Alessandro Comparini on 26/02/24.
//

import UIKit

public class TopViewAnimationHeightWithScrollBuilder: ViewBuilder, TopViewAnimationHeightWithScroll {
    public typealias T = UIScrollView
    
    private var component: BaseBuilder?
    private var initialOffset: CGFloat?
    private var lastContentOffset: CGFloat = 0.0
    private var heightChange: TopViewAnimationHeightWithScrollBuilder.HeightChange = .increasing
    private var heightAnchor: NSLayoutConstraint?
    private var scrollView: UIScrollView!
    private var stackView: StackViewToTopView!
    
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
    public func setView(_ view: BaseBuilder) -> Self {
        component = view
        component?.add(insideTo: stackView.get)
        return self
    }
    
    @discardableResult
    public func setAnimation(_ heightChange: TopViewAnimationHeightWithScrollBuilder.HeightChange) -> Self {
        self.heightChange = heightChange
        return self
    }
    
    
//  MARK: - START
    public func animation(_ scrollView: UIScrollView) {
//        setInitialOffSet(scrollView)
        setOnceHeight()
        
        guard let initialOffset else {return}
        
        let currentOffset = scrollView.contentOffset.y
        
        let animationInit: CGFloat = height.ini
        let animationFinal: CGFloat = -(abs(height.end))
        
        let animationThreshold: CGFloat = animationInit - animationFinal
        
        let scrolling = (currentOffset - initialOffset)
        let completed = (scrolling/animationThreshold)
        
        if scrolling > 0 {
            heightAnchor?.constant = min((animationThreshold)*completed, animationThreshold)
            self.get.frame = CGRect(origin: self.get.frame.origin, size: CGSize(width: self.get.frame.width, height: min((animationThreshold)*completed, animationThreshold)))
        } else {
            heightAnchor?.constant = animationInit
        }
        
        lastContentOffset = currentOffset
        
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configBackgroundColor()
        stackView = StackViewToTopView()
        stackView.add(insideTo: self.get)
        stackView.applyConstraint()
    }
    
    private func setInitialOffSet(_ scrollView: UIScrollView) {
        if initialOffset == nil {
            initialOffset = scrollView.contentOffset.y
        }
    }
    
    private func configBackgroundColor() {
        self.setBackgroundColor(.clear)
    }
    
    private func setOnceHeight() {
        if heightAnchor == nil {
            
            guard let hgt = self.get.constraints.first(where: { $0.firstAttribute == .height }) else {
                
                heightAnchor = NSLayoutConstraint(item: self.get,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .height,
                                                  multiplier: 1,
                                                  constant: height.ini)

                heightAnchor?.isActive = true
                return
            }
            
            heightAnchor = hgt
        }
    }
    
    
    
    
}
