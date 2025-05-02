//  Created by Alessandro Comparini on 01/05/25.
//

public protocol SpeechRecognitionDelegate: AnyObject {
    func output(speechText: String)
    func requestPermission()
    func permissionGranted()
    func speechRecognitionNotWork()
    func permissionDenied()
}

enum SpeechRecognitionPermission {
    case ok
    case notWork
    case requestPermission
}
