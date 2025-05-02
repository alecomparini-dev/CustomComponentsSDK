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
    
    @discardableResult
    func setWordsToClean(words: [String]) -> Self
    
    func appendAudioCapturer(buffer: AVAudioPCMBuffer)
    
    func startRecognition()
    
    func stopRecognition()
}
