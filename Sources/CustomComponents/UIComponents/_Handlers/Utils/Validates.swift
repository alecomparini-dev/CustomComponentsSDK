//  Created by Alessandro Comparini on 13/11/23.
//

import Foundation

public struct Validates {
    
    static func percent(_ percent: CGFloat) -> Bool {
        if !(0.0...100.0).contains(percent) {
            return false
        }
        return true
    }
    
}
