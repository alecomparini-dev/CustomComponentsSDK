//  Created by Alessandro Comparini on 29/04/25.
//

import CoreHaptics

public struct SystemKHapticEventParametersMapper {
    
    public static func to(_ eventParameter: SystemK.Haptic.Event.Parameters) -> CHHapticEvent.ParameterID {
        return switch eventParameter {
        case .hapticIntensity:
                .hapticIntensity
        case .hapticSharpness:
                .hapticSharpness
        case .attackTime:
                .attackTime
        case .decayTime:
                .decayTime
        case .releaseTime:
                .releaseTime
        case .sustained:
                .sustained
        case .audioVolume:
                .audioVolume
        case .audioPitch:
                .audioPitch
        case .audioPan:
                .audioPan
        case .audioBrightness:
                .audioBrightness
        }
    }
}
