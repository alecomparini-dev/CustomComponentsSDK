//  Created by Alessandro Comparini on 26/02/24.
//

import UIKit

public class TopViewAnimationHeightWithScrollBuilder: ViewBuilder, TopViewAnimationHeightWithScroll {
    public typealias T = UIScrollView
    
    private var component: BaseBuilder?
    private var initialOffset: CGFloat?
    private var direction: TopViewAnimationHeightWithScrollBuilder.Direction = .topToBottom
    private var heightAnchor: NSLayoutConstraint?
    private var scrollView: UIScrollView!
    private var stackView: StackViewToTopView!
    
    public enum Direction {
        case topToBottom
        case bottomToTop
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
    public func setAnimationDirection(_ direction: TopViewAnimationHeightWithScrollBuilder.Direction) -> Self {
        self.direction = direction
        return self
    }
    
    @discardableResult
    public func setInitialOffsetScroll(_ scrollView: UIScrollView) -> Self {
        if self.initialOffset == nil {
            self.initialOffset = scrollView.contentOffset.y
        }
        return self
    }
    
    
//  MARK: - START
    public func animation(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let animationThreshold: CGFloat = height.ini + height.end
        let scrolling = (currentOffset - (initialOffset ?? 0.0))
        let completed = (scrolling/animationThreshold)
        
        print( "initialOffset:", initialOffset,
            "currentOffset:", currentOffset,
              "animationThreshold:", animationThreshold,
              "scrolling:", scrolling,
              "completed:", completed )
        
        if scrolling > 0 {
            if direction == .bottomToTop {
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
