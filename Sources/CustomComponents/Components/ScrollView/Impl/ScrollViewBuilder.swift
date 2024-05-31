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
        return self
    }
    
    @discardableResult
    public func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self {
        scrollView.showsHorizontalScrollIndicator = flag
        return self
    }

    
}
