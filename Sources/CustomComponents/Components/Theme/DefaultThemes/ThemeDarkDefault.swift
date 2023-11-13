//  Created by Alessandro Comparini on 13/11/23.
//

import UIKit


public struct ThemeDarkDefault: ThemeColor {
    public var backgroundColor: UIColor { UIColor.HEX("#292D2E")}
    public var error: UIColor { UIColor.HEX("#c81b1a") }
    public var onError: UIColor { UIColor.HEX("#d3d3d3") }
}

extension ThemeDarkDefault: ThemePrimaryColor {
    public var primary: UIColor { UIColor.HEX("#ec9355") }
    public var onPrimary:UIColor { UIColor.HEX("#0f1010") }
    public var primaryContainer: UIColor { UIColor.HEX("#1F7799") }
    public var onPrimaryContainer: UIColor { UIColor.HEX("#FFFFFF") }
}

extension ThemeDarkDefault: ThemeSecondaryColor {
    public var secondary: UIColor { UIColor.HEX("#1a365b") }
    public var onSecondary: UIColor { UIColor.HEX("#FFFFFF") }
    public var secondaryContainer: UIColor { .black }
    public var onSecondaryContainer: UIColor { .black }
}

extension ThemeDarkDefault: ThemeTertiaryColor {
    public var tertiary: UIColor { UIColor.HEX("#ee6c29") }
    public var onTertiary: UIColor { UIColor.HEX("#0f1010") }
    public var tertiaryContainer: UIColor { .black }
    public var onTertiaryContainer: UIColor { .black }
}

extension ThemeDarkDefault: ThemeGradientColor {
    public var backgroundColorGradient: [UIColor] { [backgroundColor, backgroundColor.adjustBrightness(-60)] }
    public var primaryGradient: [UIColor] { [primary, UIColor.HEX("#FF6517")] }
    public var secondaryGradient: [UIColor] { [secondary, UIColor.HEX("#ff6b00")] }
    public var tertiaryGradient: [UIColor] { [tertiary, UIColor.HEX("#ff6b00")] }
}


extension ThemeDarkDefault: ThemeSurface {
    public var surfaceContainerHighest: UIColor { UIColor.HEX("#41484a") }
    public var surfaceContainerHigh: UIColor { surfaceContainerHighest.adjustBrightness(-25) }
    public var surfaceContainer: UIColor { surfaceContainerHighest.adjustBrightness(-40) }
    public var surfaceContainerLow: UIColor { surfaceContainerHighest.adjustBrightness(-60) }
    public var surfaceContainerLowest: UIColor { surfaceContainerHighest.adjustBrightness(-70) }

    public var onSurface: UIColor { UIColor.HEX("#d3d3d3") }
    public var onSurfaceInverse: UIColor { UIColor.HEX("#050505") }
    public var onSurfaceVariant: UIColor { onSurface.adjustBrightness(-40) }
}

