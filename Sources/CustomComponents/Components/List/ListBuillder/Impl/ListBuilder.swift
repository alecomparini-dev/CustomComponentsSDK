//  Created by Alessandro Comparini on 30/11/23.
//

import UIKit

@MainActor
public protocol ListDelegate: AnyObject {
    //REQUIRED
    func numberOfSections(_ list: ListBuilder) -> Int
    func numberOfRows(_ list: ListBuilder, section: Int) -> Int
    func sectionViewCallback(_ list: ListBuilder, section: Int) -> UIView?
    func rowViewCallBack(_ list: ListBuilder, section: Int, row: Int) -> Any
    
    //OPTIONAL
    func shouldSelectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int) -> Bool
    func didSelectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int)
    func didDeselectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int)
    func scrollViewDidScroll(_ list: ListBuilder, _ scrollView: UIScrollView)
    func scrollViewWillBeginDragging(_ list: ListBuilder, _ scrollView: UIScrollView)
}

@MainActor
open class ListBuilder: BaseBuilder, List {
    public typealias T = UITableView
    public typealias C = UITableViewCell
    public typealias S = UITableView.ScrollPosition
    
    private weak var delegate: ListDelegate?
    private var view: UIView?
    
    public var get: UITableView { list }
    
    private var rowsHeight: [Int : CGFloat] = [:]
    private var alreadyApplied = false
    
    private var completionCalculateRowHeight: ((ListBuilder, Int, Int) -> CGFloat)?
    private var customSectionHeaderHeight: [Int : CGFloat] = [:]
    private var customSectionFooterHeight: [Int : CGFloat] = [:]
    private var customRowHeight: [Int : [Int : CGFloat]] = [:]
    private var autoScrollPosition: Bool = false
    
    private var isShow = false
    
    
//  MARK: - INITIALIZERS
    
    private let list: T
    
    public init() {
        self.list = UITableView()
        super.init(list)
        configure()
    }
    
    public init(style: UITableView.Style) {
        self.list = UITableView(frame: .zero, style: style)
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
        var values = customRowHeight[forSection] ?? [:]
        values.updateValue(height, forKey: forRow)
        customRowHeight.updateValue(values, forKey: forSection)
        return self
    }
    
    @discardableResult
    public func setSectionHeaderHeight(_ height: CGFloat) -> Self {
        list.sectionHeaderHeight = height
        return self
    }
    
    @discardableResult
    public func setSectionHeaderHeight(forSection: Int, _ height: CGFloat) -> Self {
        customSectionHeaderHeight.updateValue(height, forKey: forSection)
        return self
    }
    
    @discardableResult
    public func setSectionFooterHeight(_ height: CGFloat) -> Self {
        list.sectionFooterHeight = height
        return self
    }
    
    @discardableResult
    public func setSectionFooterHeight(forSection: Int, _ height: CGFloat) -> Self {
        customSectionFooterHeight.updateValue(height, forKey: forSection)
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
        autoScrollPosition = true
        return self
    }
    
    @discardableResult
    public func setCalculateRowHeight(completion: @escaping (_ list: ListBuilder, _ section: Int, _ row: Int) -> CGFloat) -> Self {
        completionCalculateRowHeight = completion
        return self
    }

    @available(iOS 15.0, *)
    @discardableResult
    public func sectionHeaderTopPadding(_ padding: CGFloat) -> Self {
        list.sectionHeaderTopPadding = padding
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
        self.setHidden(false, animated: true)
        isShow = true
    }
    
    public func hide() {
        self.setHidden(true, animated: true)
        isShow = false        
    }
    
    public func reload(force: Bool = false) {
        if !isShow && !force { return }
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
    
    public func gotoRow(section: Int, row: Int, scrollPosition: UITableView.ScrollPosition = .top) {
        list.scrollToRow(at: IndexPath(row: row, section: section), at: scrollPosition, animated: true)
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
    
    private func selectRowAnimated(_ indexPath: IndexPath) {
        if !autoScrollPosition {
            list.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
            return
        }
        list.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
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
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.setBackgroundColor(.clear)
        return view
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell
        
        guard let cell else { return UITableViewCell() }
        
        guard let view = delegate?.rowViewCallBack(self, section: indexPath.section, row: indexPath.row) else { return UITableViewCell()}
        
        cell.setupCell(view)
        
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(self, scrollView)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDragging(self, scrollView)
    }
    
    
}


//  MARK: - Extension Delegate
extension ListBuilder: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customSectionHeaderHeight[section] ?? list.sectionHeaderHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return customSectionFooterHeight[section] ?? list.sectionFooterHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let customRowHeight = customRowHeight[indexPath.section]?[indexPath.row] {
            return customRowHeight
        }
        
        return completionCalculateRowHeight?(self, indexPath.section, indexPath.row) ?? list.rowHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRowAnimated(indexPath)
        selectItem(indexPath.section, indexPath.row)
    }
    
}



//  MARK: - EXTESION DEFAULT LIST DELEGATE
public extension ListDelegate {
    func shouldSelectItemAt(_ list: ListBuilder, _ section: Int, _ row: Int) -> Bool { return true}
    func didSelectItemAt(_ list: ListBuilder,_ section: Int, _ row: Int) {}
    func didDeselectItemAt(_ list: ListBuilder,_ section: Int, _ row: Int) {}
    func scrollViewDidScroll(_ list: ListBuilder, _ scrollView: UIScrollView) {}
    func scrollViewWillBeginDragging(_ list: ListBuilder, _ scrollView: UIScrollView) {}
}

