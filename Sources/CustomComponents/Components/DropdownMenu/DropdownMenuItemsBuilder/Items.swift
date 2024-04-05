//  Created by Alessandro Comparini on 05/04/24.
//

import Foundation

struct Items {
    let section: ViewBuilder
    var rows: [ViewBuilder]
    
    init(section: ViewBuilder, rows: [ViewBuilder] = []) {
        self.section = section
        self.rows = rows
    }
    
}
