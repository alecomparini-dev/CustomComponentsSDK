//  Created by Alessandro Comparini on 05/03/24.
//

import Foundation

public protocol Collection: AnyObject {
    associatedtype T
    associatedtype S
    
    var get: T { get }
    
    
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
    func setScrollToItem(index: Int) -> Self

    @discardableResult
    func setRegisterCell(_ cell: AnyClass) -> Self

    
}
