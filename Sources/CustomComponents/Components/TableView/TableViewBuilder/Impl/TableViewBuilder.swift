//  Created by Alessandro Comparini on 11/10/23.
//

import UIKit

open class TableViewBuilder: BaseBuilder, TableView {
    public typealias T = UITableView
    
    public var get: UITableView { self.tableView }
    
    private let tableView: UITableView

    public init() {
        self.tableView = UITableView()
        super.init(tableView)
    }


//  MARK: - SET PROPERTIES

    @discardableResult
    public func setSeparatorStyle(_ separatorStyle: K.SeparatorStyle) -> Self {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.init(rawValue: separatorStyle.rawValue) ?? .none
        return self
    }
    
    @discardableResult
    public func setShowsScroll(_ flag: Bool, _ showsScroll: K.ShowsScroll) -> Self {
        switch showsScroll {
            case .horizontal:
                tableView.showsHorizontalScrollIndicator = flag
            
            case .vertical:
                tableView.showsVerticalScrollIndicator = flag
            
            case .both:
                tableView.showsVerticalScrollIndicator = flag
                tableView.showsHorizontalScrollIndicator = flag
        }
        return self
    }
    
    @discardableResult
    public func setScrollEnabled(_ flag: Bool) -> Self {
        tableView.isScrollEnabled = flag
        return self
    }
    
    @discardableResult
    public func setRegisterCell(_ cell: AnyClass) -> Self {
        tableView.register(cell, forCellReuseIdentifier: String(describing: cell.self))
        return self
    }
    
    @discardableResult
    public func setTableFooter(_ tableFooter: ViewBuilder) -> Self {
        tableView.tableFooterView = tableFooter.get
        return self
    }
    
}
