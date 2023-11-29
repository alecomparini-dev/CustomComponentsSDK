//  Created by Alessandro Comparini on 29/11/23.
//

import UIKit

public protocol DockDelegate: AnyObject {
    //REQUIRED
    func numberOfItemsCallback() -> Int
    func cellItemCallback(_ indexItem: Int) -> UIView
    
    //OPTIONAL
    func shouldSelectItemAt(_ indexItem: Int) -> Bool
    func didSelectItemAt(_ indexItem: Int)
    func didDeselectItemAt(_ indexItem: Int)
    func removeItem(_ indexItem: Int)
    func insertItem(_ indexItem: Int)
}


open class DockBuilder: BaseBuilder, Dock {
    private weak var delegate: DockDelegate?
    public typealias T = UIView
    public typealias C = UICollectionView
    
    private var isShow = false
    private var customItemSize: [Int:CGSize] = [:]
    private var cellSize = K.Dock.Default.cellSize
    
    
//  MARK: - INITIALIZERS
    public var get: UIView { _dock.get }
    
    private let _layout: UICollectionViewFlowLayout
    private let _dock: ViewBuilder
    private let _collection: UICollectionView
    
    public init() {
        self._layout = UICollectionViewFlowLayout()
        self._dock = ViewBuilder()
        self._collection = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
        super.init(_dock.get)
    }
    
    
//  MARK: - PUBLIC GET
    
    public var collection: UICollectionView { _collection }
    
    public var isShowing: Bool { isShow }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setCustomCellSize(indexCell: Int, _ size: CGSize) -> Self {
        customItemSize.updateValue(size, forKey: indexCell)
        return self
    }
    
    @discardableResult
    public func setCellsSize(_ size: CGSize) -> Self {
        cellSize = size
        return self
    }
    
    @discardableResult
    public func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self {
        collection.showsHorizontalScrollIndicator = flag
        return self
    }
    
    
    @discardableResult
    public func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) -> Self {
        return self
    }
    
    @discardableResult
    public func setMinimumLineSpacing(_ minimumSpacing: CGFloat) -> Self {
        return self
    }
    
    @discardableResult
    public func setIsUserInteractionEnabledItems(_ isUserInteractionEnabled: Bool) -> Self {
        return self
    }
    
    
//  MARK: - SET DELEGATE
    @discardableResult
    public func setDelegate(delegate: DockDelegate) -> Self {
        
        return self
    }
    
    
//  MARK: - ACTIONS AREA
    public var show: Void {
        isShow = true
        return
    }
    
    public var hide: Void {
        isShow = false
        return
    }
    
    
    public func reload() {
        
    }
    
    public func insertItem(_ indexItem: Int) {
        
    }
    
    public func selectItem(_ indexItem: Int, at: K.Dock.ScrollPosition) {
        
    }
    
    public func deselect(_ indexItem: Int) {
        
    }
    
    public func removeItem(_ indexItem: Int) {
        
    }
    
    
}



//  MARK: - Extension Delegate Flow Layout
extension DockBuilder: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return customItemSize[indexPath.row] ?? K.Dock.Default.cellSize
    }
    
}



extension DockDelegate {
    func shouldSelectItemAt(_ indexItem: Int) -> Bool { return true }
    func didSelectItemAt(_ indexItem: Int) {}
    func didDeselectItemAt(_ indexItem: Int) {}
    func removeItem(_ indexItem: Int) {}
    func insertItem(_ indexItem: Int) {}
}
