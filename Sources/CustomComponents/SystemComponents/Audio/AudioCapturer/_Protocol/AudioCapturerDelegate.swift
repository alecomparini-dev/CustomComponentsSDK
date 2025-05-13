//  Created by Alessandro Comparini on 30/04/25.
//

import AVFoundation

public protocol AudioCapturerDelegate: AnyObject {
    func audioCapturerWillStart()
    func audioCapturerDidStartCapturing()
    func audioCapturerDidStop()
    func requestPermission()
    func outputBuffer(buffer: AVAudioPCMBuffer)
    func error(_ error: AudioCapturerError )
}
