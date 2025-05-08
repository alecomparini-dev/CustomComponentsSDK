//  Created by Alessandro Comparini on 30/04/25.
//

import Foundation
import AVFoundation

public protocol AudioCapturer {
    var delegate: AudioCapturerDelegate? { get set }
    func checkPermission() -> AudioCapturerPermission
    
    func requestPermission() async -> RequestPermissionStatus
    
    func initiateEngine() async throws
    
    func finalizeEngine() async throws
    
    func startAudioCapture() async throws
    
    func stopAudioCapture()

}
