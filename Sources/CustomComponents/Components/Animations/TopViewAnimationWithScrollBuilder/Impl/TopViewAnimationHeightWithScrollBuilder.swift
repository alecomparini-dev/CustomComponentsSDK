//  Created by Alessandro Comparini on 26/02/24.
//

import UIKit

public class TopViewAnimationHeightWithScrollBuilder: BaseBuilder, TopViewAnimationHeightWithScroll {
    private var initialOffset: CGFloat = 0.0
    private var lastContentOffset: CGFloat = 0.0
    private var heightChange: TopViewAnimationHeightWithScrollBuilder.HeightChange = .increasing
    private var heightAnchor: NSLayoutConstraint!
    private var startHeight: (ini: CGFloat, end: CGFloat)!
    private var currentOffset: CGFloat = 0.0
    
    public enum HeightChange {
        case increasing
        case decreasing
    }
    
    public var get: ViewBuilder { self.view }
    
//  MARK: - INITIALIZERS
    
    private let scrollView: UIScrollView
    private var view: ViewBuilder

    public init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        self.view = ViewBuilder()
        super.init(view.get)
        configure()
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setView(_ viewBuilder: ViewBuilder) -> Self {
        viewBuilder.add(insideTo: self.view.get)
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
    public func start(height: (ini: CGFloat, end: CGFloat)) {
        
        self.startHeight = height
        let animationInit: CGFloat = height.ini
        let animationFinal: CGFloat = -(abs(height.end))
        
        let animationThreshold: CGFloat = animationInit - animationFinal
        
        let scrolling = (currentOffset - initialOffset)
        let completed = (scrolling/animationThreshold)
        
        
        if scrolling > 0 {
            heightAnchor.constant = min((animationThreshold)*completed, animationThreshold)
        } else {
            heightAnchor.constant = animationInit
        }
        
    }
    
//  MARK: - PRIVATE AREA
    private func configure() {
        createView()
        currentOffset = scrollView.contentOffset.y
    }
    
    private func createView() {
        view = ViewBuilder()
            .setBackgroundColor(.clear)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView
            }
        
        heightAnchor = NSLayoutConstraint(item: view,
                                          attribute: .height,
                                          relatedBy: .equal,
                                          toItem: nil,
                                          attribute: .height,
                                          multiplier: 1,
                                          constant: startHeight.ini)
    }
    
}
