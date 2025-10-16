//  Created by Alessandro Comparini on 16/10/25.
//

import Foundation

public protocol HapticFeedbackProtocol {
        
    func play(_ type: HapticFeedbackType)
    
    func stopEngine()
}
