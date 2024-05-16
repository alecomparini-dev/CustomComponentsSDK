//  Created by Alessandro Comparini on 05/03/24.
//

import UIKit


open class CollectionBuilder: BaseBuilder, Collection {
    public typealias T = UICollectionView
    public typealias C = UICollectionViewCell
    public typealias S = UICollectionView.ScrollDirection
    
    
    //  MARK: - INITIALIZERS
    public var get: T { collection }
    
    private var layout: UICollectionViewFlowLayout
    private let collection: T
    
    public init() {
        self.layout = UICollectionViewFlowLayout()
        self.collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(collection)
    }
    
    
//  MARK: - GET PROPERTIES
    
    public func getCellForItem(section: Int = 0, cell: Int) -> UICollectionViewCell? {
        let indexPath = IndexPath(row: cell, section: section)
        setScrollToItem(section: section, cell: cell)
        let cell = collection.cellForItem(at: indexPath)
        return cell
    }
    
    public func getCellSelected() -> [UICollectionViewCell] {
        var cells = [UICollectionViewCell]()
        
        if let indexPaths = collection.indexPathsForSelectedItems {
            for indexPath in indexPaths {
                if let cell = collection.cellForItem(at: indexPath) {
                    cells.append(cell)
                }
            }
        }
        
        return cells
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
    public func setScrollDirection(_ direction: S) -> Self {
        layout.scrollDirection = direction
        return self
    }
    
    @discardableResult
    public func setSelectItem(section: Int = 0, cell: Int) -> Self {
        let indexPath = IndexPath(row: cell, section: section)
        collection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        return self
    }
    
    @discardableResult
    public func setScrollToItem(section: Int = 0, cell: Int) -> Self {
        let indexPath = IndexPath(row: cell, section: section)
        var scrollPosition: UICollectionView.ScrollPosition = .centeredHorizontally
        if layout.scrollDirection == .vertical { scrollPosition = .centeredVertically  }
        collection.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
        return self
    }
    
    
//  MARK: - REGISTER CELL
    
    public func setRegisterCell(_ cell: AnyClass) -> Self {
        collection.register(cell, forCellWithReuseIdentifier: String(describing: cell.self))
        return self
    }
    
    
//  MARK: - SET DELEGATE
    
    public func setDelegate(delegate: UICollectionViewDelegateFlowLayout) {
        collection.delegate = delegate
    }
    
    public func setDataSource(dataSource: UICollectionViewDataSource) {
        collection.dataSource = dataSource
    }
    
}
