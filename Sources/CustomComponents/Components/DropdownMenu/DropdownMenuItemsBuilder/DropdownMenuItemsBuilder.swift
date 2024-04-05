//  Created by Alessandro Comparini on 05/04/24.
//

import UIKit

public class DropdownMenuItemsBuilder {
    
    private var section: ViewBuilder?
    private var rows: [ViewBuilder] = []
    private var items: [ViewBuilder : [ViewBuilder]] = [:]
    
    public init() {  }
    
    
//  MARK: - GET PROPERTIES
    var get: [ViewBuilder : [ViewBuilder]] { items }
    
    
//  MARK: - SET PROPORTIES
    @discardableResult
    public func setSection(_ sectionView:  ViewBuilder) -> Self {
        section = sectionView
        items.updateValue([], forKey: sectionView)
        rows = []
        return self
    }
    
    @discardableResult
    public func setRow(_ rowView:  ViewBuilder) -> Self {
        guard let section else {return self}
        rows.append(rowView)
        items.updateValue(rows, forKey: section)
        return self
    }

        
}
