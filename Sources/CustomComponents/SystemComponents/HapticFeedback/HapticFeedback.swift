//  Created by Alessandro Comparini on 28/04/25.
//

import Foundation


protocol HapticFeedback {
    
    func setIntensity(intensity: Float) -> Self
    
    func setSharpness(sharpness: Float) -> Self
    
    func vibrateOnce()
}
