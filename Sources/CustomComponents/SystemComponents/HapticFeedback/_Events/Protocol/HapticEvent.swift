//  Created by Alessandro Comparini on 16/10/25.
//

import CoreHaptics

protocol HapticEvent {
    func event() -> [CHHapticEvent]
}
