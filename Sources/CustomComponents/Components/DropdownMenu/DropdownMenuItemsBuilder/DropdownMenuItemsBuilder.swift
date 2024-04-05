//  Created by Alessandro Comparini on 05/04/24.
//

import UIKit


public class DropdownMenuItemsBuilder {
    
    struct Items {
        let section: ViewBuilder
        var rows: [ViewBuilder]
    }
    
    private var section: ViewBuilder?
    private var rows: [ViewBuilder] = []
    private var items: [Items] = []
    
    public init() {  }
    
    
//  MARK: - GET PROPERTIES
    var get: [Items] { items }
    
    
//  MARK: - SET PROPORTIES
    @discardableResult
    public func setSection(_ sectionView:  ViewBuilder) -> Self {
        let items = Items(section: sectionView, rows: [])
        self.items.append(items)
        return self
    }
    
    @discardableResult
    public func setRow(_ rowView:  ViewBuilder) -> Self {
        var items = self.items.last
        items?.rows.append(rowView)
        return self
    }

        
}
