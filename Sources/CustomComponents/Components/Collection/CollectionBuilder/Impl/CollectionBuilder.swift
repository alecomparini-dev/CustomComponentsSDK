//  Created by Alessandro Comparini on 05/03/24.
//

import UIKit


open class CollectionBuilder: BaseBuilder, Collection {
    public typealias C = UICollectionView
    
    
    //  MARK: - INITIALIZERS
    public var get: UIView { collection }
    
    private var layout: UICollectionViewFlowLayout
    private let collection: UICollectionView
    
    public init() {
        self.layout = UICollectionViewFlowLayout()
        self.collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(collection)
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self {
        collection.showsHorizontalScrollIndicator = flag
        return self
    }
    
    @discardableResult
    public func setShowsVerticalScrollIndicator(_ flag: Bool) -> Self {
        collection.showsVerticalScrollIndicator = flag
        return self
    }
    
    @discardableResult
    public func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) -> Self {
        collection.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: rigth)
        return self
    }
    
    
    @discardableResult
    public func setMinimumLineSpacing(_ space: CGFloat) -> Self {
        layout.minimumLineSpacing = space
        return self
    }
    
    @discardableResult
    public func setMinimumInteritemSpacing(_ space: CGFloat) -> Self {
        layout.minimumInteritemSpacing = space
        return self
    }
       
    @discardableResult
    public func setScrollDirection(_ direction: UICollectionView.ScrollDirection) -> Self {
        layout.scrollDirection = direction
        return self
    }
    
    @discardableResult
    public func setScrollToItem(index: Int) -> Self {
        let indexPath = IndexPath(row: index, section: 0)
        var scrollPosition: UICollectionView.ScrollPosition = .centeredHorizontally
        if layout.scrollDirection == .vertical { scrollPosition = .centeredVertically  }
        collection.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
        return self
    }
    
    
    
    //  MARK: - SET DELEGATE
    public func setDelegate(delegate: UICollectionViewDelegate) {
        collection.delegate = delegate
    }
    
    public func setDataSource(dataSource: UICollectionViewDataSource) {
        collection.dataSource = dataSource
    }
    
}
