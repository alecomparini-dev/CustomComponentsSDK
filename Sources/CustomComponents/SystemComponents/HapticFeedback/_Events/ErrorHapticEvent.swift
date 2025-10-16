//  Created by Alessandro Comparini on 16/10/25.
//


import CoreHaptics

struct ErrorHapticEvent: HapticEvent {
    
    func event() -> [CHHapticEvent] {
        [  CHHapticEvent(eventType: .hapticContinuous,
                         parameters: [
                            .init(parameterID: .hapticIntensity, value: 1.0),
                            .init(parameterID: .hapticSharpness, value: 0.2)
                         ],
                         relativeTime: 0,
                         duration: 0.5),
           
           CHHapticEvent(eventType: .hapticTransient,
                         parameters: [
                            .init(parameterID: .hapticIntensity, value: 0.7),
                            .init(parameterID: .hapticSharpness, value: 0.3)
                         ],
                         relativeTime: 0.55),
           
           CHHapticEvent(eventType: .hapticTransient,
                         parameters: [
                            .init(parameterID: .hapticIntensity, value: 0.7),
                            .init(parameterID: .hapticSharpness, value: 0.3)
                         ],
                         relativeTime: 0.65)
        ]
    }
    
}


