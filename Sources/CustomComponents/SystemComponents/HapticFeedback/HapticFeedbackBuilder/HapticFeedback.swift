//  Created by Alessandro Comparini on 28/04/25.
//

import Foundation


public protocol HapticFeedback {
    
    @discardableResult
    func setHapticMode(mode: HapticMode) -> Self
    
    @discardableResult
    func setIntensity(intensity value: Float) -> Self
    
    @discardableResult
    func setSharpness(sharpness value: Float) -> Self
    
    @discardableResult
    func setHapticEventParameter(eventParameter: SystemK.Haptic.Event.Parameters, value: Float) -> Self
    
    func vibrateOnce(delayStart: Double?)
    
    func vibrateTwice(delayStart: Double?, delayRepeat: Double)
    
    func vibrate(times: Int, delayStart: Double?, delayRepeat: Double)
}
