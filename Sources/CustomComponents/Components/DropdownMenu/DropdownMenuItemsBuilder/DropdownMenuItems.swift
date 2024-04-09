//  Created by Alessandro Comparini on 05/04/24.
//

import Foundation

class DropdownMenuItems {
    let section: BaseBuilder
    var rows: [BaseBuilder]
    
    init(section: BaseBuilder, rows: [BaseBuilder] = []) {
        self.section = section
        self.rows = rows
    }
    
}
