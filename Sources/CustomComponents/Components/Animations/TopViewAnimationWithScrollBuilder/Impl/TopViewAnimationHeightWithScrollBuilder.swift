//  Created by Alessandro Comparini on 26/02/24.
//

import UIKit

public class TopViewAnimationHeightWithScrollBuilder: ViewBuilder, TopViewAnimationHeightWithScroll {
    public typealias T = UIScrollView
    
    private var component: BaseBuilder?
    private var initialOffset: CGFloat?
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
        setInitialOffSet(scrollView)
        
        guard let initialOffset else {return}
        
        let currentOffset = scrollView.contentOffset.y
        let animationThreshold: CGFloat = height.ini + height.end
        let scrolling = (currentOffset - initialOffset)
        let completed = (scrolling/animationThreshold)
        
        print("currentOffset:", currentOffset,
              "animationThreshold:", animationThreshold,
              "scrolling:", scrolling,
              "completed:", completed )
        
        if scrolling > 0 {
            if heightChange == .decreasing {
                heightAnchor?.constant = max( min( height.ini - (animationThreshold*completed), animationThreshold), height.end)
                return
            }
            heightAnchor?.constant = min( (animationThreshold) * completed, animationThreshold)
        } else {
            heightAnchor?.constant = height.ini
        }
        
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configBackgroundColor()
        stackView = StackViewToTopView()
        stackView.add(insideTo: self.get)
        stackView.applyConstraint()
        setOnceHeight()
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
