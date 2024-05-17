//  Created by Alessandro Comparini on 11/10/23.
//

import Foundation

public protocol TableView {
    associatedtype T
    associatedtype S
    
    var get: T { get }
    
    @discardableResult
    func setSeparatorStyle( _ separatorStyle: K.SeparatorStyle) -> Self
    
    @discardableResult
    func setShowsScroll(_ flag: Bool, _ showsScroll: K.ShowsScroll) -> Self 
    
    @discardableResult
    func setScrollEnabled(_ flag: Bool) -> Self
    
    @discardableResult
    func setScrollToItem(section: Int, row: Int, scrollPosition: S ) -> Self
    
    @discardableResult
    func setRegisterCell(_ cell: AnyClass ) -> Self
    
    @discardableResult
    func setTableFooterView(_ tableFooter: ViewBuilder ) -> Self
    
    @discardableResult
    func setTableHeaderView(_ tableFooter: ViewBuilder ) -> Self
    
    @discardableResult
    func setPadding(top: CGFloat?, left: CGFloat?, bottom: CGFloat?, right: CGFloat?) -> Self
    
    @discardableResult
    func setSectionFooterHeight(_ height: CGFloat) -> Self
    
    @available(iOS 15.0, *)
    @discardableResult
    func sectionHeaderTopPadding(_ padding: CGFloat) -> Self
}
