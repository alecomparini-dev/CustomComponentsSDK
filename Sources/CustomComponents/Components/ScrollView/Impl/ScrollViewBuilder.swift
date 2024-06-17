//  Created by Alessandro Comparini on 14/05/24.
//

import UIKit

@MainActor
open class ScrollViewBuilder: BaseBuilder, ScrollView {
    public typealias S = UIScrollView
    
    public var get: UIScrollView { scrollView }
    
    private let scrollView: UIScrollView
    
    public init() {
        self.scrollView = UIScrollView()
        super.init(scrollView)
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setShowsVerticalScrollIndicator(_ flag: Bool) -> Self {
        scrollView.showsVerticalScrollIndicator = flag
//        scrollView.get..
        return self
    }
    
    @discardableResult
    public func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self {
        scrollView.showsHorizontalScrollIndicator = flag
        return self
    }

    @discardableResult
    public func setPaddingInputToKeyboard(_ padding: CGFloat) -> Self {
        scrollView.contentInset.bottom = padding
        return self
    }
    
    @discardableResult
    public func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        scrollView.contentInset.top = top
        scrollView.contentInset.left = left
        scrollView.contentInset.bottom = bottom
        scrollView.contentInset.right = right
        return self
    }
    
    @discardableResult
    public func setVerticalScrollIndicatorInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        scrollView.verticalScrollIndicatorInsets.top = top
        scrollView.verticalScrollIndicatorInsets.left = left
        scrollView.verticalScrollIndicatorInsets.bottom = bottom
        scrollView.verticalScrollIndicatorInsets.right = right
        return self
    }
    
}
