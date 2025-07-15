//  Created by Alessandro Comparini on 15/07/25.
//

import UIKit

public struct BaseAnimationParameters {
    public var fromValue: Any? = 1.0
    public var toValue: Any? = 0
    public var duration: TimeInterval = 0.5
    public var autoReverse: Bool = true
    public var repeatCount: Float? = nil
    public var timingFunction = CAMediaTimingFunction(name: .linear)
    
    public init() { }
}
