//  Created by Alessandro Comparini on 13/11/23.
//

import UIKit

open class Theme {
    static let shared = Theme()
    
    var currentTheme: ThemeProtocol
    
    private init() {
        self.currentTheme = ThemeDarkDefault()
    }
    
    static func setTheme(_ theme: ThemeProtocol) {
        Theme.shared.currentTheme = theme
    }
    
}
