//  Created by Alessandro Comparini on 10/05/25.
//

import Foundation

@MainActor
public protocol ScaleAnimation {
    func setScale(_ scale: CGFloat) -> Self
}
