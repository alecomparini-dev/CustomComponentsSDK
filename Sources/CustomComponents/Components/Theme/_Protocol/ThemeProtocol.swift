//  Created by Alessandro Comparini on 13/11/23.
//

import UIKit

public protocol ThemeProtocol: ThemePrimaryColor, ThemeSecondaryColor, ThemeTertiaryColor, ThemeSurface, ThemeGradientColor {
    var backgroundColor: UIColor { get }
    var error: UIColor { get }
    var onError: UIColor { get }
}

public protocol ThemePrimaryColor {
    var primary: UIColor { get }
    var onPrimary: UIColor { get }
    var primaryContainer: UIColor { get }
    var onPrimaryContainer: UIColor { get }
}

public protocol ThemeSecondaryColor {
    var secondary: UIColor { get }
    var onSecondary: UIColor { get }
    var secondaryContainer: UIColor { get }
    var onSecondaryContainer: UIColor { get }
}

public protocol ThemeTertiaryColor {
    var tertiary: UIColor { get }
    var onTertiary: UIColor { get }
    var tertiaryContainer: UIColor { get }
    var onTertiaryContainer: UIColor { get }
}

public protocol ThemeGradientColor {
    var backgroundColorGradient: [UIColor] { get }
    var primaryGradient: [UIColor] { get }
    var secondaryGradient: [UIColor] { get }
    var tertiaryGradient: [UIColor] { get }
}

public protocol ThemeSurface {
    var surfaceContainerLowest: UIColor { get }
    var surfaceContainerLow: UIColor { get }
    var surfaceContainer: UIColor { get }
    var surfaceContainerHigh: UIColor { get }
    var surfaceContainerHighest: UIColor { get }
    
    var onSurface: UIColor { get }
    var onSurfaceVariant: UIColor { get }
    var onSurfaceInverse: UIColor { get }

}
