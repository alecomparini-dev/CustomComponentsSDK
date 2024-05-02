//  Created by Alessandro Comparini on 23/04/24.
//

import UIKit

public protocol DockDelegate: AnyObject {
    //REQUIRED
    func numberOfItemsCallback(_ dockBuilder: DockBuilder) -> Int
    func cellCallback(_ dockBuilder: DockBuilder, _ index: Int) -> UIView
    func customCellActiveCallback(_ dockBuilder: DockBuilder, _ cell: UIView) -> UIView?
    
    //OPTIONAL
    func shouldSelectItemAt(_ dockBuilder: DockBuilder, _ index: Int) -> Bool
    func didSelectItemAt(_ dockBuilder: DockBuilder, _ index: Int)
    func didDeselectItemAt(_ dockBuilder: DockBuilder, _ index: Int)
    func removeItem(_ dockBuilder: DockBuilder, _ index: Int)
    func insertItem(_ dockBuilder: DockBuilder, _ index: Int)
}
