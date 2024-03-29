//  Created by Alessandro Comparini on 05/03/24.
//

import Foundation

public protocol Collection: AnyObject {
    associatedtype T
    associatedtype C
    associatedtype D
    associatedtype S
    
    var get: T { get }
    
    var collection: C { get }
        
    var isShowing: Bool { get }
    
    func getCellSelected() -> D?
    
    func getIndexSelected() -> Int?

    func getCellByIndex(_ index: Int?) -> D?

    func isSelected(_ index: Int) -> Bool
    
    func getIndexForVisibleItems() -> [Int]
    
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    func setCustomCellSize(index: Int, _ size: CGSize) -> Self
    
    @discardableResult
    func setCellsSize(_ size: CGSize) -> Self
    
    @discardableResult
    func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self
    
    @discardableResult
    func setShowsVerticalScrollIndicator(_ flag: Bool) -> Self
    
    @discardableResult
    func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) -> Self
    
    @discardableResult
    func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) -> Self
    
    @discardableResult
    func setMinimumLineSpacing(_ space: CGFloat) -> Self
    
    @discardableResult
    func setMinimumInteritemSpacing(_ space: CGFloat) -> Self
    
    @discardableResult
    func setDisableUserInteraction(_ flag: Bool ) -> Self
    
    @discardableResult
    func setDisableUserInteraction(cells: [Int]) -> Self
    
    @discardableResult
    func setScrollDirection(_ direction: S) -> Self
    
    @discardableResult
    func setScrollToItem(index: Int) -> Self
    
    @discardableResult
    func setEnableToggleItemSelection(_ flag: Bool) -> Self
    
    
    
//  MARK: - DELEGATE
    @discardableResult
    func setDelegate(_ delegate: CollectionDelegate) -> Self
    
    
//  MARK: - SET ACTIONS
    
    func show()
    
    func hide()
    
    func reload()
        
    func selectItem(_ index: Int, at: K.Dock.ScrollPosition)
    
    func deselect(_ index: Int)
    
    func removeCell(_ index: Int)
    
    func insertCell(_ index: Int)
    

    
}
