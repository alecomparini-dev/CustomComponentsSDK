//  Created by Alessandro Comparini on 17/10/25.
//


import CoreHaptics

struct CriticalErrorHapticEvent: HapticEvent {
    
    func event() -> [CHHapticEvent] {
        [  CHHapticEvent(eventType: .hapticContinuous,
                         parameters: [
                            .init(parameterID: .hapticIntensity, value: 1.0),
                            .init(parameterID: .hapticSharpness, value: 0.2)
                         ],
                         relativeTime: 0,
                         duration: 0.4),
           
           CHHapticEvent(eventType: .hapticContinuous,
                         parameters: [
                            .init(parameterID: .hapticIntensity, value: 1.0),
                            .init(parameterID: .hapticSharpness, value: 0.2)
                         ],
                         relativeTime: 0.5,
                         duration: 0.4),
        ]
    }
    
}
