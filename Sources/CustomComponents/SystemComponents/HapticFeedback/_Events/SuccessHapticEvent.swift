//  Created by Alessandro Comparini on 16/10/25.
//

import CoreHaptics

struct SuccessHapticEvent: HapticEvent {
    
    func _event() -> [CHHapticEvent] {
        [  CHHapticEvent(eventType: .hapticTransient,
                         parameters: [
                            .init(parameterID: .hapticIntensity, value: 0.5),
                            .init(parameterID: .hapticSharpness, value: 0.7)
                         ],
                         relativeTime: 0),
           
           CHHapticEvent(eventType: .hapticTransient,
                         parameters: [
                            .init(parameterID: .hapticIntensity, value: 0.8),
                            .init(parameterID: .hapticSharpness, value: 0.8)
                         ],
                         relativeTime: 0.15)
        ]
    }
    
    
    func event() -> [CHHapticEvent] {
        [  CHHapticEvent(eventType: .hapticContinuous,
                         parameters: [
                            .init(parameterID: .hapticIntensity, value: 0.5),
                            .init(parameterID: .hapticSharpness, value: 0.7)
                         ],
                         relativeTime: 0,
                         duration: 0.2),
           
           CHHapticEvent(eventType: .hapticContinuous,
                         parameters: [
                            .init(parameterID: .hapticIntensity, value: 0.8),
                            .init(parameterID: .hapticSharpness, value: 0.8)
                         ],
                         relativeTime: 0.25,
                         duration: 0.2),
        ]
    }
    
    
    
    
}


