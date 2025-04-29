//  Created by Alessandro Comparini on 29/04/25.
//

import Foundation


public struct SystemK {
    
    public struct Default {
        
    }

}


//  MARK: - EXTENSION - Haptic

extension SystemK {
    public struct Haptic {
        
        public struct Event {
            
            public enum Parameters {
                case hapticIntensity
                case hapticSharpness
                case attackTime
                case decayTime
                case releaseTime
                case sustained
                case audioVolume
                case audioPitch
                case audioPan
                case audioBrightness
            }
            
            public enum EventType {
                case hapticTransient
                case hapticContinuous
                case audioContinuous
                case audioCustom
            }
        }
    }
}
