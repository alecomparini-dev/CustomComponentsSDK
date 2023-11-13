//  Created by Alessandro Comparini on 13/11/23.
//

import UIKit

open class ThemeBuilder {
    static let shared = ThemeBuilder()
    
    var currentTheme: ThemeColor
    
    private init() {
        self.currentTheme = ThemeDarkDefault()
    }
    
    static func setTheme(_ theme: ThemeColor) {
        ThemeBuilder.shared.currentTheme = theme
    }
    
}
