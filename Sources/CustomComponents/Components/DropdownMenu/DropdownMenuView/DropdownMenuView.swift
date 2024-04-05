//  Created by Alessandro Comparini on 05/04/24.
//

import UIKit

class DropdownMenuList: ListBuilder {
    
    public override init(style: UITableView.Style) {
        super.init(style: style)
        configure()
    }
   
    
//  MARK: - PRIVATE AREA
    public func configure() {
        self
            .setRowHeight(10)
            .setCustomRowHeight(forSection: 0, forRow: 1, 10)
            .setSectionHeaderHeight(10)
            .setPadding(top: 0, left: 0, bottom: 0, right: 0)
            
    }
    
    
}
