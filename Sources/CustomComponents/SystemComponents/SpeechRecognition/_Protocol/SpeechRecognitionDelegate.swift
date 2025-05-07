//  Created by Alessandro Comparini on 01/05/25.
//

public protocol SpeechRecognitionDelegate: AnyObject {
    func output(speechText: String)
    
    func requestSpeechPermission()
    func speechPermissionGranted()
    func speechPermissionNotWork()
    func speechPermissionDenied()
}

public enum SpeechRecognitionPermission {
    case requestPermission
    case denied
    case authorized
    case unavailable
}
