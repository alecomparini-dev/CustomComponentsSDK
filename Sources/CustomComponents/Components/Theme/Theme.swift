//  Created by Alessandro Comparini on 13/11/23.
//

import UIKit


open class Theme {
    static public let shared = Theme()
    
    public var currentTheme: ThemeProtocol
    
    private init() {
        self.currentTheme = ThemeDarkDefault()
    }
    
    static public func setTheme(_ theme: ThemeProtocol) {
        Theme.shared.currentTheme = theme
    }
    
}
