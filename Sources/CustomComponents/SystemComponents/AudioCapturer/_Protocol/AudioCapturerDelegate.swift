//  Created by Alessandro Comparini on 30/04/25.
//

import AVFoundation


public protocol AudioCapturerDelegate: AnyObject {
    func audioCapturerStarted()
    func audioCapturerStoped()
    func outputAudioCapture(buffer: AVAudioPCMBuffer)
    func requestPermission()
    func error(type: AudioCapturerError)
}
