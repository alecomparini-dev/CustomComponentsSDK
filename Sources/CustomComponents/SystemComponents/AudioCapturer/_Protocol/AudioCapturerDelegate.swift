//  Created by Alessandro Comparini on 30/04/25.
//

import AVFoundation

public protocol AudioCapturerDelegate: AnyObject {
    func outputAudioCapture(buffer: AVAudioPCMBuffer)
    func requestPermission()
    func permissionGranted()
    func permissionDenied()
}
