//  Created by Alessandro Comparini on 30/11/23.
//

import UIKit

public protocol ListDelegate: AnyObject {
    //REQUIRED
    func numberOfSections(_ list: ListBuilder) -> Int
    func numberOfRows(_ list: ListBuilder, section: Int) -> Int
    func sectionViewCallback(_ list: ListBuilder, section: Int) -> UIView?
    func rowViewCallBack(_ list: ListBuilder, section: Int, row: Int) -> UIView
    
    //OPTIONAL
    func shouldSelectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int) -> Bool
    func didSelectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int)
    func didDeselectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int)
}


open class ListBuilder: BaseBuilder, List {
    private weak var delegate: ListDelegate?
    
    public var get: UITableView { list }
    
    private var alreadyApplied = false
    private var listModel = ListModel()
    private var isShow = false
    
    
//  MARK: - INITIALIZERS
    
    private let list: T
    
    public init() {
        self.list = UITableView()
        super.init(list)
        configure()
    }
    
    
//  MARK: - GET AREA

    public var isShowing: Bool { !list.isHidden }
    
    public func getRowSelected() -> UITableViewCell? {
        guard let indexSelected = getIndexSelected() else {return nil}
        if let cell = getRowByIndex(indexSelected.section, indexSelected.row ) {
            return cell
        }
        return nil
    }
    
    public func getIndexSelected() -> (section: Int, row: Int)? {
        if let selectedIndexPath = list.indexPathForSelectedRow {
            return (section: selectedIndexPath.section, row: selectedIndexPath.row)
        }
        return nil
    }
    
    public func isSelected(_ section: Int? = 0, _ row: Int) -> Bool {
        return getIndexSelected() ?? (-1,-1) == (section, row)
    }
    

    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setRowHeight(_ height: CGFloat) -> Self {
        list.rowHeight = height
        return self
    }
    
    @discardableResult
    public func setCustomRowHeight(forSection: Int, forRow: Int, _ height: CGFloat) -> Self {
        listModel.customRowHeight.updateValue([forRow : height], forKey: forSection)
        return self
    }
    
    @discardableResult
    public func setSectionHeaderHeight(_ height: CGFloat) -> Self {
        list.sectionHeaderHeight = height
        return self
    }
    
    @discardableResult
    public func setSectionHeaderHeight(forSection: Int, _ height: CGFloat) -> Self {
        listModel.customSectionHeaderHeight.updateValue(height, forKey: forSection)
        return self
    }
    
    @discardableResult
    public func setSectionFooterHeight(_ height: CGFloat) -> Self {
        list.sectionFooterHeight = height
        return self
    }
    
    @discardableResult
    public func setSectionFooterHeight(forSection: Int, _ height: CGFloat) -> Self {
        listModel.customSectionFooterHeight.updateValue(height, forKey: forSection)
        return self
    }
    
    @discardableResult
    public func setIsScrollEnabled(_ flag: Bool) -> Self {
        list.isScrollEnabled = flag
        return self
    }
    
    @discardableResult
    public func setSeparatorStyle(_ separatorStyle: K.SeparatorStyle) -> Self {
        list.separatorStyle = UITableViewCell.SeparatorStyle.init(rawValue: separatorStyle.rawValue) ?? .none
        return self
    }
    
    @discardableResult
    public func setShowsScroll(_ flag: Bool, _ showsScroll: K.ShowsScroll) -> Self {
        switch showsScroll {
            case .horizontal:
                list.showsHorizontalScrollIndicator = flag
            
            case .vertical:
                list.showsVerticalScrollIndicator = flag
            
            case .both:
                list.showsVerticalScrollIndicator = flag
                list.showsHorizontalScrollIndicator = flag
        }
        return self
    }
    
    @discardableResult
    public func setFooterView(_ footerView: ViewBuilder) -> Self {
        list.tableFooterView = footerView.get
        return self
    }
    
    @discardableResult
    public func setHeaderView(_ headerView: ViewBuilder) -> Self {
        list.tableHeaderView = headerView.get
        return self
    }
    
    @discardableResult
    public func setPadding(top: CGFloat?, left: CGFloat?, bottom: CGFloat?, right: CGFloat?) -> Self {
        list.contentInset = UIEdgeInsets(top: top ?? 0,
                                         left: left ?? 0,
                                         bottom: bottom ?? 0,
                                         right: right ?? 0)
        return self
    }
    
    @discardableResult
    public func setAutoScrollPosition() -> Self {
        listModel.autoScrollPosition = true
        return self
    }

    
//  MARK: - SET DELEGATE
    @discardableResult
    public func setDelegate(_ delegate: ListDelegate ) -> Self {
        self.delegate = delegate
        return self
    }
    
    
//  MARK: - ACTIONS AREA
    public func show() {
        if isShow { return }
        applyOnceConfig()
        list.setHidden(false)
        isShow = true
    }
    
    public func hide() {
        list.setHidden(true)
        isShow = false
    }
    
    public func reload() {
        if !isShow { return }
        list.reloadData()
    }
    
    public func selectItem(_ section: Int? = 0, _ row: Int) {
        if isSelected(section, row) {
            delegate?.didSelectItemAt(self, section ?? 0, row)
            return
        }
        
        if !(delegate?.shouldSelectItemAt(self, section ?? 0, row) ?? true) { return }
        
        if let indexSelect = getIndexSelected() { delegate?.didDeselectItemAt(self, indexSelect.section , indexSelect.row) }
        
        let indexPath = IndexPath(row: row, section: section ?? 0)
        
        selectRowAnimated(indexPath)
        
        delegate?.didSelectItemAt(self, section ?? 0, row)
    }
    
    private func selectRowAnimated(_ indexPath: IndexPath) {
        if !listModel.autoScrollPosition {
            list.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            return
        }
        list.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
    }
    
    public func deselect(_ section: Int = 0, _ row: Int) {
        let indexPath = IndexPath(row: row, section: section)
        list.deselectRow(at: indexPath, animated: true)
        delegate?.didDeselectItemAt(self, section, row)
    }
    

//  MARK: - PRIVATE AREA
    private func configure() {
        setSeparatorStyle(.none)
        setBackgroundColor(.clear)
    }
    
    private func configureTableViewDelegate() {
        list.delegate = self
        list.dataSource = self
    }
    
    private func applyOnceConfig() {
        if alreadyApplied { return }
        configureTableViewDelegate()
        registerCell()
    }
    
    private func registerCell() {
        list.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
    }
    
    private func getRowByIndex(_ section: Int? = 0, _ row: Int?) -> UITableViewCell? {
        guard let row else { return nil }
        
        let indexPath = IndexPath(row: row, section: section ?? 0)
        
        if let selectedRow = list.cellForRow(at: indexPath) {
            return selectedRow
        }
        return nil
    }
        
}


//  MARK: - Extension Data Source
extension ListBuilder: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let delegate else {
            fatalError("List delegate has not been implemented")
        }
        return delegate.numberOfSections(self)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let delegate else {
            fatalError("List delegate has not been implemented")
        }
        return delegate.numberOfRows(self, section: section)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let view = delegate?.sectionViewCallback(self, section: section) {
            let cell = ListCell()
            cell.setupCell(view)
            return cell
        }
        
        return nil
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        
        cell.selectionStyle = .none
        
        let view = delegate?.rowViewCallBack(self, section: indexPath.section, row: indexPath.row) ?? UIView()
        
        cell.setupCell(view)
                
        return cell
    }
    
    
}


//  MARK: - Extension Delegate
extension ListBuilder: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return listModel.customSectionHeaderHeight[section] ?? list.sectionHeaderHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return listModel.customSectionFooterHeight[section] ?? list.sectionFooterHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listModel.customRowHeight[indexPath.section]?[indexPath.row] ?? list.rowHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectRowAnimated(indexPath)
//        selectItem(indexPath.section, indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}




//  MARK: - EXTESION DEFAULT LIST DELEGATE
public extension ListDelegate {
    func shouldSelectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int) -> Bool { return true}
    func didSelectItemAt(_ list: ListBuilder,_ section: Int, _ row: Int) {}
    func didDeselectItemAt(_ list: ListBuilder,_ section: Int, _ row: Int) {}
}

