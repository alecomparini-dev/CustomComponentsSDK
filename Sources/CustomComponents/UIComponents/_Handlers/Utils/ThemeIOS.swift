//  Created by Alessandro Comparini on 20/10/23.
//

import UIKit


public struct ThemeIOS {

    public static func isDarkMode() -> Bool {
        if let windowScene = CurrentWindow.get {
            let currentTraitCollection = windowScene.traitCollection
            
            if currentTraitCollection.userInterfaceStyle == .light {
                return false
            }
            
            if currentTraitCollection.userInterfaceStyle == .dark {
                return true
            }
        }
        return false
    }
}


    
    

