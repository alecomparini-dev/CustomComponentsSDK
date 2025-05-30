//  Created by Alessandro Comparini on 13/11/23.
//

import Foundation
import UIKit

public struct Validates {
    
    static func percent(_ percent: CGFloat) -> Bool {
        if !(0.0...100.0).contains(percent) { return false }
        return true
    }
    
    static func isValidIndexPath(_ indexPath: IndexPath, _ tableView: UITableView) -> Bool {
        guard indexPath.section >= .zero,
                indexPath.section < tableView.numberOfSections else { return false }
        
        return indexPath.row >= .zero && indexPath.row < tableView.numberOfRows(inSection: indexPath.section)
    }
    
}
