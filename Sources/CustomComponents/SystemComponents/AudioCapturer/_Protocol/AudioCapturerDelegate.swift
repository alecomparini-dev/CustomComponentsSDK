//  Created by Alessandro Comparini on 30/04/25.
//

import AVFoundation


public protocol AudioCapturerDelegate: AnyObject {
    func audioCapturerStarted()
    func audioCapturerStopped()
    func outputAudioCapture(buffer: AVAudioPCMBuffer)
    func error(type: AudioCapturerError)
}
