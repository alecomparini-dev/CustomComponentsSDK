//  Created by Alessandro Comparini on 01/05/25.
//

import AVFoundation
import Speech

public protocol SpeechRecognition {
    var delegate: SpeechRecognitionDelegate? { get set }
    
    @discardableResult
    func setShouldReportPartialResults(_ flag: Bool) -> Self
    
    @discardableResult
    func setDefaultTaskHint(taskHint: SFSpeechRecognitionTaskHint) -> Self
    
    @discardableResult
    func setSpeechLocale(locale: Locale) -> Self
    
    func checkPermission() -> SFSpeechRecognizerAuthorizationStatus
    
    func requestPermission() async -> SFSpeechRecognizerAuthorizationStatus
    
    func initiateSpeechRecognition()
    
    func startRecognition()
    
    func stopRecognition()
    
    func appendAudioCapturer(buffer: AVAudioPCMBuffer)
}
