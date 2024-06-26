//  Created by Alessandro Comparini on 30/11/23.
//

import Foundation

@MainActor
public protocol List {
    associatedtype T
    associatedtype C
    associatedtype S
    
    var get: T { get }
    
    func getRowSelected() -> C?
    
    func getIndexSelected() -> (section: Int, row: Int)?

    func isSelected(_ section: Int?, _ row: Int) -> Bool
    
    var isShowing: Bool { get }
    
    
    
//  MARK: - ACTIONS AREA
    
    func show()
    
    func hide()
    
    func reload(force: Bool)
    
    func selectItem(_ section: Int?, _ row: Int)
    
    func gotoRow(section: Int, row: Int, scrollPosition: S)
    
    func deselect(_ section: Int, _ row: Int)
    

    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    func setRowHeight(_ height: CGFloat) -> Self
    
    @discardableResult
    func setCustomRowHeight(forSection: Int, forRow: Int, _ height: CGFloat) -> Self
    
    @discardableResult
    func setSectionHeaderHeight(_ height: CGFloat) -> Self
    
    @discardableResult
    func setSectionHeaderHeight(forSection: Int, _ height: CGFloat) -> Self
    
    @discardableResult
    func setSectionFooterHeight(_ height: CGFloat) -> Self
    
    @discardableResult
    func setSectionFooterHeight(forSection: Int, _ height: CGFloat) -> Self
    
    @discardableResult
    func setIsScrollEnabled(_ flag: Bool) -> Self
    
    @discardableResult
    func setAutoScrollPosition() -> Self
    
    @discardableResult
    func setSeparatorStyle(_ separatorStyle: K.SeparatorStyle) -> Self 
    
    @discardableResult
    func setPadding(top: CGFloat?, left: CGFloat?, bottom: CGFloat?, right: CGFloat?) -> Self
    
    @discardableResult
    func setFooterView(_ footerView: ViewBuilder) -> Self 
    
    @discardableResult
    func setHeaderView(_ headerView: ViewBuilder) -> Self
    
    @discardableResult
    func setShowsScroll(_ flag: Bool, _ showsScroll: K.ShowsScroll) -> Self
    
    @discardableResult
    func setCalculateRowHeight(completion: @escaping (_ list: ListBuilder, _ section: Int, _ row: Int) -> CGFloat) -> Self
    
    @available(iOS 15.0, *)
    @discardableResult
    func sectionHeaderTopPadding(_ padding: CGFloat) -> Self
    
    
//  MARK: - DELEGATE
    @discardableResult
    func setDelegate(_ delegate: ListDelegate) -> Self
}
