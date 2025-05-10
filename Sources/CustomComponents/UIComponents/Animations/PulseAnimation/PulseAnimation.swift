//  Created by Alessandro Comparini on 10/05/25.
//

import Foundation

@MainActor
public protocol PulseAnimation: Animation {
    func setScalePulse(scaleX: CGFloat, y: CGFloat) -> Self
}
