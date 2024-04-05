//  Created by Alessandro Comparini on 05/04/24.
//

import Foundation

class DropdownMenuItems {
    let section: ViewBuilder
    var rows: [ViewBuilder]
    
    init(section: ViewBuilder, rows: [ViewBuilder] = []) {
        self.section = section
        self.rows = rows
    }
    
}
