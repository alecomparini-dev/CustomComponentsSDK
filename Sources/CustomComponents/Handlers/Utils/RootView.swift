//  Created by Alessandro Comparini on 13/09/23.
//

import UIKit

public struct RootView {
    static var get: UIView? {
        if let rootView = CurrentWindow.get?.rootViewController?.view {
            return rootView
        }
        return nil
    }
}



