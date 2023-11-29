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
    public typealias D = UICollectionViewCell
    
    private var isUserInteractionEnabledItems = false
    private var alreadyApplied = false
    private var isShow = false
    private var customItemSize: [Int:CGSize] = [:]
    private var cellSize = K.Dock.Default.cellSize
    
    
//  MARK: - INITIALIZERS
    public var get: UIView { dock.get }
    
    private let layout: UICollectionViewFlowLayout
    private let dock: ViewBuilder
    private let _collection: UICollectionView
    
    public init() {
        self.layout = UICollectionViewFlowLayout()
        self.dock = ViewBuilder()
        self._collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(dock.get)
        configure()
    }
    
    
//  MARK: - PUBLIC GET
    
    public var collection: UICollectionView { _collection }
    
    public var isShowing: Bool { isShow }
    
    public func getIndexSelected() -> Int? {
        if let selectedIndexPaths = collection.indexPathsForSelectedItems?.first {
            let selectedIndex = selectedIndexPaths.item
            return selectedIndex
        }
        return nil
    }

    public func getCellSelected() -> UICollectionViewCell? {
        guard let indexSelected = getIndexSelected() else {return nil}
        if let cell = getCellByIndex(indexSelected) {
            return cell
        }
        return nil
    }

    public func isSelected(_ indexCell: Int) -> Bool {
        return getIndexSelected() == indexCell
    }
    
    
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
        collection.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: rigth)
        return self
    }
    
    @discardableResult
    public func setMinimumLineSpacing(_ minimumSpacing: CGFloat) -> Self {
        layout.minimumLineSpacing = minimumSpacing
        return self
    }
    
    @discardableResult
    public func setIsUserInteractionEnabledItems(_ isUserInteractionEnabled: Bool) -> Self {
        isUserInteractionEnabledItems = isUserInteractionEnabled
        return self
    }
    
    
//  MARK: - SET DELEGATE
    @discardableResult
    public func setDelegate(delegate: DockDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    
//  MARK: - ACTIONS AREA
    public var show: Void {
        if isShow {return}
        isShow = true
        applyOnceConfig()
        dock.setHidden(false)
    }
    
    public var hide: Void {
        isShow = false
        dock.setHidden(true)
    }
    
    public func reload() {
        if !isShow {return}
        collection.reloadData()
    }
    
    public func selectItem(_ indexCell: Int, at: K.Dock.ScrollPosition = .centeredHorizontally) {
        if isSelected(indexCell) {return}
        
        if !(delegate?.shouldSelectItemAt(indexCell) ?? true) { return }
        
        if let indexSelect = getIndexSelected() { delegate?.didDeselectItemAt(indexSelect) }
        
        let indexPath = IndexPath(row: indexCell, section: 0)
        
        collection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        delegate?.didSelectItemAt(indexCell)
    }
    
    public func deselect(_ indexCell: Int) {
        let indexPath = IndexPath(row: indexCell, section: 0)
        collection.deselectItem(at: indexPath, animated: true)
        delegate?.didDeselectItemAt(indexCell)
    }
    
    public func removeItem(_ indexItem: Int) {
        //TODO: - Implements after
    }
    
    public func insertItem(_ indexItem: Int) {
        //TODO: - Implements after
    }

    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configLayout()
        configCollection()
        configDefault()
        registerCell()
    }
    
    private func addElements() {
        _collection.add(insideTo: dock.get)
    }
    
    private func configCollectionDelegate() {
        collection.delegate = self
        collection.dataSource = self
    }
    
    private func configLayout() {
        layout.scrollDirection = .horizontal
    }
    
    private func configDefault() {
        self.setMinimumLineSpacing(10)
        self.setContentInset(top: 10, left: 10, bottom: 10, rigth: 10)
        self.setShowsHorizontalScrollIndicator(false)
    }
    
    private func configCollection() {
        collection.setCollectionViewLayout(layout, animated: true)
        collection.backgroundColor = .clear
    }
    
    private func configConstraints() {
        collection.makeConstraints { make in
            make
                .setTop.setBottom.equalToSuperView
                .setLeading.setTrailing.equalToSuperView(8)
                .apply()
        }
    }
    
    private func registerCell() {
        collection.register(DockCell.self, forCellWithReuseIdentifier: DockCell.identifier)
    }
    
    private func getCellByIndex(_ index: Int?) -> UICollectionViewCell? {
        guard let index else { return nil}
        let indexPath = IndexPath(row: index, section: 0)
        if let selectedCell = collection.cellForItem(at: indexPath) {
            return selectedCell
        }
        return nil
    }
    
    private func applyOnceConfig() {
        if alreadyApplied { return }
        configCollectionDelegate()
        DispatchQueue.main.async { [weak self] in
            self?.configConstraints()
            self?.alreadyApplied = true
        }
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
            let item = delegate.cellItemCallback(indexPath.row)
            item.isUserInteractionEnabled = isUserInteractionEnabledItems
            cell.setupCell(item)
        }
        
        return cell
    }
        
}



//  MARK: - Extension Delegate Flow Layout
extension DockBuilder: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return customItemSize[indexPath.row] ?? cellSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegate?.didDeselectItemAt(indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return delegate?.shouldSelectItemAt(indexPath.row) ?? true
    }
    
}



//  MARK: - EXTESION DEFAULT DOCK DELEGATE
extension DockDelegate {
    func shouldSelectItemAt(_ indexItem: Int) -> Bool { return true }
    func didSelectItemAt(_ indexItem: Int) {}
    func didDeselectItemAt(_ indexItem: Int) {}
    func removeItem(_ indexItem: Int) {}
    func insertItem(_ indexItem: Int) {}
}
