//  Created by Alessandro Comparini on 29/11/23.
//

import Foundation

public protocol Dock: AnyObject {
    associatedtype T
    associatedtype C
    var get: T { get }
    var collection: C { get }
    
    var show: Void { get }
    
    var hide: Void { get }
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setCustomCellSize(indexCell: Int, _ size: CGSize) -> Self
    
    @discardableResult
    func setCellsSize(_ size: CGSize) -> Self
    
    @discardableResult
    func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self
    
    @discardableResult
    func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) -> Self
    
    @discardableResult
    func setMinimumLineSpacing(_ minimumSpacing: CGFloat) -> Self
    
    @discardableResult
    func setIsUserInteractionEnabledItems(_ isUserInteractionEnabled: Bool) -> Self
    
    
//  MARK: - DELEGATE
    @discardableResult
    func setDelegate(delegate: DockDelegate ) -> Self
    
    
//  MARK: - SET ACTIONS
    func reload()
        
    func selectItem(_ indexItem: Int, at: K.Dock.ScrollPosition)
    
    func deselect(_ indexItem: Int)
    
    func removeItem(_ indexItem: Int)
    
    func insertItem(_ indexItem: Int)
    

    
}
