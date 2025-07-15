//  Created by Alessandro Comparini on 14/07/25.
//

import Foundation

@MainActor
public protocol FadeAnimation: Animation {
    
    @discardableResult
    func setFadeIn() -> Self

    @discardableResult
    func setFadeOut() -> Self
}
