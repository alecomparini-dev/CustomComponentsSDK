//  Created by Alessandro Comparini on 28/04/25.
//

public enum HapticMode {
    case zen
    case normal
    case turbo
    case explosion
    case pulse
    
    var baseIntensity: Float {
        switch self {
        case .zen: return 0.3
        case .normal: return 0.5
        case .turbo: return 0.8
        case .explosion: return 1.0
        case .pulse: return 0.6
        }
    }
    
    var baseSharpness: Float {
        switch self {
        case .zen: return 0.2
        case .normal: return 0.5
        case .turbo: return 0.7
        case .explosion: return 1.0
        case .pulse: return 0.9
        }
    }
}
