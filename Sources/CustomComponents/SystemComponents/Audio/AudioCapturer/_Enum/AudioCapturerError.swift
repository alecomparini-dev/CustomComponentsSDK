//  Created by Alessandro Comparini on 05/05/25.
//

public enum AudioCapturerError: Error {
    case audioSessionConfigurationError(_ error: String)
    case audioSessionFinalizeEngineError(_ error: String)
    case startAudioCaptureError(_ error: String)
    case audioEngineStartError(_ error: String)
}
