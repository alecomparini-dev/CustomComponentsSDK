//  Created by Alessandro Comparini on 13/05/25.
//

enum AudioCapturerState {
    case none
    case initiate
    case willStartCapture
    case capturing
    case stopped
    case finalized
}
