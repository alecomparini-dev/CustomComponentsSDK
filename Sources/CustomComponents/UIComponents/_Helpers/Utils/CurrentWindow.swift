//  Created by Alessandro Comparini on 13/09/23.
//

import UIKit

public struct CurrentWindow {
    public static var get: UIWindow? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first {
            return mainWindow
        }
        return nil
    }
}

