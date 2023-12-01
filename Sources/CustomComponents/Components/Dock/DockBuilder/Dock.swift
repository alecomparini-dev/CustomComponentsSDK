//  Created by Alessandro Comparini on 29/11/23.
//

import Foundation

public protocol Dock: AnyObject {
    associatedtype T
    associatedtype C
    associatedtype D
    
    var get: T { get }
    
    var collection: C { get }
        
    var isShowing: Bool { get }
    
    func getCellSelected() -> D?
    
    func getIndexSelected() -> Int?

    func isSelected(_ indexCell: Int) -> Bool
    
    func getIndexForVisibleItems() -> [Int]
    
    func getCellByIndex(_ indexItem: Int) -> D?
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    func setCustomCellSize(indexCell: Int, _ size: CGSize) -> Self
    
    @discardableResult
    func setCellsSize(_ size: CGSize) -> Self
    
    @discardableResult
    func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self
    
    @discardableResult
    func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) -> Self
    
    @discardableResult
    func setMinimumLineSpacing(_ space: CGFloat) -> Self
    
    @discardableResult
    func setMinimumInteritemSpacing(_ space: CGFloat) -> Self
    
    @discardableResult
    func setIsUserInteractionEnabledItems(_ isUserInteractionEnabled: Bool) -> Self
    
    
//  MARK: - DELEGATE
    @discardableResult
    func setDelegate(delegate: DockDelegate) -> Self
    
    
//  MARK: - SET ACTIONS
    
    func show()
    
    func hide()
    
    func reload()
        
    func selectItem(_ indexCell: Int, at: K.Dock.ScrollPosition)
    
    func deselect(_ indexCell: Int)
    
    func removeCell(_ indexCell: Int)
    
    func insertCell(_ indexCell: Int)
    

    
}
