//  Created by Alessandro Comparini on 05/04/24.
//

import UIKit


public class DropdownMenuItemsBuilder {
    
    private var items: [DropdownMenuItems] = []
    
    public init() {  }
    
    
//  MARK: - GET PROPERTIES
    var get: [DropdownMenuItems] { items }
    
    
//  MARK: - SET PROPORTIES
    @discardableResult
    public func setSection(_ sectionView:  ViewBuilder) -> Self {
        let item = DropdownMenuItems(section: sectionView, rows: [])
        items.append(item)
        return self
    }
    
    @discardableResult
    public func setRow(_ rowView:  ViewBuilder) -> Self {
        let item = items[items.count-1]
        item.rows.append(rowView)
        return self
    }

        
}
