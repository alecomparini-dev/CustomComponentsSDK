//  Created by Alessandro Comparini on 05/05/25.
//

public enum AudioCapturerError {
    case audioSessionCategory(_ error: String)
    case audioSessionActivate(_ error: String)
}
