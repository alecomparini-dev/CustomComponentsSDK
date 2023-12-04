//  Created by Alessandro Comparini on 04/12/23.
//

import Foundation

public protocol Picker: AnyObject {
    associatedtype T
    
    var get: T { get }
    
    var isShowing: Bool { get }
    
    func getRowSelected(inComponent: Int) -> Int
    
    @discardableResult
    func setRowHeight(_ height: CGFloat ) -> Self
    
    
//  MARK: - SET DELEGATE
    @discardableResult
    func setDelegate(_ delegate:  PickerDelegate) -> Self

    
//  MARK: - SET ACTIONS
    
    func show()
    
    func hide()
    
    func reload(component: Int?)
        
    func selectItem(component: Int, _ row: Int)
    
}
