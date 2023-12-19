//  Created by Alessandro Comparini on 19/12/23.
//

import Foundation

public protocol Blur {
    @discardableResult
    func setOpacity(_ opacity: CGFloat) -> Self 
}
