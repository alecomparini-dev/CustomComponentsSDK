//  Created by Alessandro Comparini on 16/10/25.
//

import CoreHaptics

struct TapHapticEvent: HapticEvent {
    
    func event() -> [CHHapticEvent] {
        [  CHHapticEvent(eventType: .hapticTransient,
                         parameters: [
                           .init(parameterID: .hapticIntensity, value: 0.4),
                           .init(parameterID: .hapticSharpness, value: 0.6)
                         ],
                         relativeTime: 0)
        ]
    }
    
}
