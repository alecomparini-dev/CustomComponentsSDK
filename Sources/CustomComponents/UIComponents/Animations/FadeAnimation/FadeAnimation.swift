//  Created by Alessandro Comparini on 14/07/25.
//

import Foundation

public protocol FadeAnimation: Animation {
    func setIn(_ value: CGFloat)
    
    func setOut(_ value: CGFloat)
}
