//  Created by Alessandro Comparini on 30/04/25.
//

import Foundation
import AVFoundation

public protocol AudioCapturer {
    var delegate: AudioCapturerDelegate? { get set }
    
    func setAudioSessionCategory(_ category: AVAudioSession.Category,
                                 mode: AVAudioSession.Mode,
                                 options: AVAudioSession.CategoryOptions)
    
    func setActiveOptions(activeOptions: AVAudioSession.SetActiveOptions)

    func startAudioCapture() throws
    
    func stopAudioCapture()
}
