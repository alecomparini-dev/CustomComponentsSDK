//  Created by Alessandro Comparini on 01/05/25.
//


public protocol SpeechRecognitionDelegate: AnyObject {
    func output(speechText: String)
}
