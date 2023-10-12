//  Created by Alessandro Comparini on 11/10/23.
//

import Foundation

public protocol TableView {
    associatedtype T
    var get: T { get }   
    
    @discardableResult
    func setSeparatorStyle( _ separatorStyle: K.SeparatorStyle) -> Self
    
    @discardableResult
    func setShowsScroll(_ flag: Bool, _ showsScroll: K.ShowsScroll) -> Self 
    
    @discardableResult
    func setScrollEnabled(_ flag: Bool) -> Self
    
    @discardableResult
    func setRegisterCell(_ cell: AnyClass ) -> Self
    
    @discardableResult
    func setTableFooter(_ tableFooter: ViewBuilder ) -> Self
    
}
