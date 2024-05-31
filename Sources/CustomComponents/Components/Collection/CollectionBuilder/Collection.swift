//  Created by Alessandro Comparini on 05/03/24.
//

import Foundation

@MainActor
public protocol Collection: AnyObject {
    associatedtype T
    associatedtype C
    associatedtype S
    
    var get: T { get }
    
    
//  MARK: - GET PROPERTIES
    func getCellForItem(section: Int, cell: Int) -> C?
    
    func getCellSelected() -> [C]
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self
    
    @discardableResult
    func setShowsVerticalScrollIndicator(_ flag: Bool) -> Self
    
    @discardableResult
    func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) -> Self
    
    @discardableResult
    func setMinimumLineSpacing(_ space: CGFloat) -> Self
    
    @discardableResult
    func setMinimumInteritemSpacing(_ space: CGFloat) -> Self
    
    @discardableResult
    func setScrollDirection(_ direction: S) -> Self
    
    @discardableResult
    func setScrollToItem(section: Int, cell: Int) -> Self
    
    @discardableResult
    func setSelectItem(section: Int, cell: Int) -> Self

    @discardableResult
    func setRegisterCell(_ cell: AnyClass) -> Self

    
}
