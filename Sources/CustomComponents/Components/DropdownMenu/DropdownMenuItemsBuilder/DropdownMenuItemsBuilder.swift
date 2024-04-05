//  Created by Alessandro Comparini on 05/04/24.
//

import UIKit

public class DropdownMenuItemsBuilder {
    
    private(set) var section: ViewBuilder?
    private(set) var rows: [ViewBuilder] = []
    
    public init() {  }
    
    @discardableResult
    public func setSection(_ sectionView:  ViewBuilder) -> Self {
        section = sectionView
        return self
    }
    
    @discardableResult
    public func setRow(_ rowView:  ViewBuilder) -> Self {
        rows.append(rowView)
        return self
    }

        
}
