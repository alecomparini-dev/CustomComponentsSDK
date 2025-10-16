//  Created by Alessandro Comparini on 16/10/25.
//


import CoreHaptics

struct WarningHapticEvent: HapticEvent {
    
    func event() -> [CHHapticEvent] {
        [  CHHapticEvent(eventType: .hapticTransient,
                         parameters: [
                           .init(parameterID: .hapticIntensity, value: 0.7),
                           .init(parameterID: .hapticSharpness, value: 0.3)
                         ],
                         relativeTime: 0),
           
           CHHapticEvent(eventType: .hapticTransient,
                         parameters: [
                           .init(parameterID: .hapticIntensity, value: 0.7),
                           .init(parameterID: .hapticSharpness, value: 0.3)
                         ],
                         relativeTime: 0.1)
        ]
    }
    
}
