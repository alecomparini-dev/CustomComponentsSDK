//  Created by Alessandro Comparini on 29/11/23.
//

import UIKit

public protocol DockDelegate: AnyObject {
    //REQUIRED
    func numberOfItemsCallback() -> Int
    func cellCallback(_ index: Int) -> UIView
    func customCellActiveCallback(_ cell: UIView) -> UIView?
    
    //OPTIONAL
    func shouldSelectItemAt(_ index: Int) -> Bool
    func didSelectItemAt(_ index: Int)
    func didDeselectItemAt(_ index: Int)
    func removeItem(_ index: Int)
    func insertItem(_ index: Int)
}


open class DockBuilder: BaseBuilder, Dock {
    private weak var delegate: DockDelegate?
    public typealias T = UIView
    public typealias C = UICollectionView
    public typealias D = UICollectionViewCell
    
    private var dockCellsInactive: [Int: UIView]? = [:]
    private var indexesSelected: Set<Int> = []
    private var isUserInteractionEnabledItems = false
    private var alreadyApplied = false
    private var isShow = false
    private var customItemSize: [Int:CGSize] = [:]
    private var cellSize = K.Dock.Default.cellSize
    
    
//  MARK: - INITIALIZERS
    public var get: UIView { dock.get }
    
    private var layout: UICollectionViewFlowLayout
    private let dock: ViewBuilder
    private let _collection: UICollectionView
    
    public init() {
        self.layout = UICollectionViewFlowLayout()
        self.dock = ViewBuilder()
        self._collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(dock.get)
        configure()
    }
    
    
//  MARK: - PUBLIC GET
    
    public var collection: UICollectionView { _collection }
    
    public var isShowing: Bool { isShow }
    
    public func getIndexSelected() -> Int? {
        //TODO: PREPARED TO MULTI SELECTED
        return Array(indexesSelected).first
    }

    public func getCellSelected() -> UICollectionViewCell? {
        guard let indexSelected = getIndexSelected() else {return nil}
        if let cell = getCellByIndex(indexSelected) {
            return cell
        }
        return nil
    }
    
    public func getCellByIndex(_ index: Int?) -> UICollectionViewCell? {
        guard let index else { return nil}
        let indexPath = IndexPath(row: index, section: 0)
        if let selectedCell = collection.cellForItem(at: indexPath) {
            return selectedCell
        }
        return nil
    }
    
    public func getIndexForVisibleItems() -> [Int] {
        return collection.indexPathsForVisibleItems.compactMap({ $0.row })
    }

    public func isSelected(_ index: Int) -> Bool {
        return getIndexSelected() == index
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setCustomCellSize(index: Int, _ size: CGSize) -> Self {
        customItemSize.updateValue(size, forKey: index)
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
        collection.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: rigth)
        return self
    }
    
    @discardableResult
    public func setMinimumLineSpacing(_ space: CGFloat) -> Self {
//        if let collectionViewFlowLayout = _collection.collectionViewLayout as? UICollectionViewFlowLayout {
//            collectionViewFlowLayout.minimumLineSpacing = space
//        }
        layout.minimumLineSpacing = space
        return self
    }
    
    @discardableResult
    public func setMinimumInteritemSpacing(_ space: CGFloat) -> Self {
//        if let collectionViewFlowLayout = _collection.collectionViewLayout as? UICollectionViewFlowLayout {
//            collectionViewFlowLayout.minimumInteritemSpacing = space
//        }
        layout.minimumInteritemSpacing = space
        return self
    }
    
    @discardableResult
    public func setIsUserInteractionEnabledItems(_ isUserInteractionEnabled: Bool) -> Self {
        isUserInteractionEnabledItems = isUserInteractionEnabled
        return self
    }
    
    @discardableResult
    public func setScrollDirection(_ direction: UICollectionView.ScrollDirection) -> Self {
        layout.scrollDirection = direction
        return self
    }

    
    
//  MARK: - SET DELEGATE
    @discardableResult
    public func setDelegate(delegate: DockDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    
//  MARK: - ACTIONS AREA
    public func show() {
        if isShow { return }
        isShow = true
        applyOnceConfig()
        dock.setHidden(false)
    }
    
    public func hide() {
        isShow = false
        dock.setHidden(true)
    }
    
    public func reload() {
        if !isShow { return }
        collection.reloadData()
    }
    
    public func selectItem(_ index: Int, at: K.Dock.ScrollPosition = .centeredHorizontally) {
        if isSelected(index) {
            delegate?.didSelectItemAt(index)
            return
        }
        
        if !(delegate?.shouldSelectItemAt(index) ?? true) { return }
        
        let indexPath = IndexPath(row: index, section: 0)
        collection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        if let cell = getCellByIndex(indexPath.row) as? DockCell {
            dockCellsInactive?.updateValue(cell.contentView , forKey: index)
            setCustomCellActiveCallback(cell: cell)
        }
        
//        //TODO: REFACTOR
//        if let indexSelect = getIndexSelected() {
//            removeIndexSelected(indexSelect)
//            _collection.reloadItems(at: [IndexPath(row: indexSelect, section: 0)])
//            delegate?.didDeselectItemAt(indexSelect)
//        }
        
        setIndexSelected(indexPath.row)
        
        delegate?.didSelectItemAt(index)
    }
    
    public func deselect(_ index: Int) {
        removeIndexSelected(index)
        let indexPath = IndexPath(row: index, section: 0)
        _collection.deselectItem(at: indexPath, animated: true)
        _collection.reloadItems(at: [indexPath])
        delegate?.didDeselectItemAt(index)
    }
    
    public func removeCell(_ index: Int) {
        //TODO: - Implements after
    }
    
    public func insertCell(_ index: Int) {
        //TODO: - Implements after
    }

    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configCollection()
        configDefault()
        registerCell()
    }
    
    private func addElements() {
        _collection.add(insideTo: dock.get)
    }
    
    private func configCollectionDelegate() {
        _collection.delegate = self
        _collection.dataSource = self
    }
    
    private func configDefault() {
        setMinimumLineSpacing(10)
        setShowsHorizontalScrollIndicator(false)
    }
    
    private func configCollection() {
        _collection.backgroundColor = .clear
        setScrollDirection(.horizontal)
    }
    
    private func configConstraints() {
        _collection.makeConstraints { make in
            make
                .setTop.setBottom.equalToSuperView
                .setLeading.setTrailing.equalToSuperView
                .apply()
        }
    }
    
    private func registerCell() {
        _collection.register(DockCell.self, forCellWithReuseIdentifier: DockCell.identifier)
    }
    
    private func applyOnceConfig() {
        if alreadyApplied { return }
        configCollectionDelegate()
        DispatchQueue.main.async { [weak self] in
            self?.configConstraints()
            self?.alreadyApplied = true
        }
    }
    
    private func setCustomCellActiveCallback(cell: UICollectionViewCell) {
        if let cellDock = cell as? DockCell {
            if let view = delegate?.customCellActiveCallback(cellDock) {
                cellDock.setupCell(view)
            }
        }
    }
    
    private func setIndexSelected(_ index: Int) {
        indexesSelected.insert(index)
    }
    
    private func removeIndexSelected(_ index: Int) {
        indexesSelected.remove(index)
    }

}


//  MARK: - Extension DataSource
extension DockBuilder: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate else {
            fatalError("Dock delegate has not been implemented")
        }
        return delegate.numberOfItemsCallback()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DockCell.identifier, for: indexPath) as! DockCell
        
        if let delegate {
            
            let item = delegate.cellCallback(indexPath.row)
            
            item.isUserInteractionEnabled = false
            
            cell.setupCell(item)
            
            if indexesSelected.contains(indexPath.row) {
                setCustomCellActiveCallback(cell: cell)
            }
        }
        
        return cell
    }        
}



//  MARK: - Extension Delegate Flow Layout
extension DockBuilder: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return customItemSize[indexPath.row] ?? cellSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        delegate?.didDeselectItemAt(indexPath.row)
        deselect(indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return delegate?.shouldSelectItemAt(indexPath.row) ?? true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadItems(at: [indexPath])
        selectItem(indexPath.row, at: .centeredHorizontally)
    }
    
}



//  MARK: - EXTESION DEFAULT DOCK DELEGATE
public extension DockDelegate {
    func shouldSelectItemAt(_ index: Int) -> Bool { return true }
    func didSelectItemAt(_ index: Int) {}
    func didDeselectItemAt(_ index: Int) {}
    func removeItem(_ index: Int) {}
    func insertItem(_ index: Int) {}
}
