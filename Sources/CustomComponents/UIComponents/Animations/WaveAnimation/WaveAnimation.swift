//  Created by Alessandro Comparini on 12/05/25.
//

import UIKit
import AVFAudio

@MainActor
public protocol WaveAnimation {
    
    @discardableResult
    func setWave(velocity: VelocityWave) -> Self
    
    @discardableResult
    func setWave(maxHeight amplitude: CGFloat) -> Self
    
    @discardableResult
    func setLine(width: CGFloat) -> Self
    
    @discardableResult
    func setLine(color: UIColor) -> Self
    
    
    //[0.0 .. 1.0]
    func updateAmplitude(_ value: Float)
    
    func updateAmplitude(buffer: AVAudioPCMBuffer)
    
    func startAnimation()
    
    func stopAnimation()
}
