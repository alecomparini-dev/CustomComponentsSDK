//  Created by Alessandro Comparini on 30/04/25.
//

import Foundation
import AVFoundation

public protocol AudioCapturer {
    var delegate: AudioCapturerDelegate? { get set }
    
    func setAudioSessionCategory(_ category: AVAudioSession.Category,
                                 mode: AVAudioSession.Mode,
                                 options: AVAudioSession.CategoryOptions) throws
    
    func setAudioSessionActivate(_: Bool,
                                 options: AVAudioSession.SetActiveOptions) throws
        
    func startAudioCapture() throws
    
    func stopAudioCapture()
}
