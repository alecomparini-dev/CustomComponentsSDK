//  Created by Alessandro Comparini on 14/07/25.
//

import Foundation

@MainActor
public protocol FadeAnimation: Animation {
    func setFade(in: CGFloat, out: CGFloat)
}
