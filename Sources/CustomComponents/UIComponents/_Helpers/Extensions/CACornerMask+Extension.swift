//  Created by Alessandro Comparini on 08/11/23.
//

import UIKit

extension CACornerMask {
    
    var toRectCorner: UIRectCorner {
        var corner: UIRectCorner = []
        
        if contains(.layerMinXMinYCorner) {
            corner.insert(.topLeft)
        }
        
        if contains(.layerMaxXMinYCorner) {
            corner.insert(.topRight)
        }
        
        if contains(.layerMinXMaxYCorner) {
            corner.insert(.bottomLeft)
        }
        
        if contains(.layerMaxXMaxYCorner) {
            corner.insert(.bottomRight)
        }
        return corner
    }
    
}
