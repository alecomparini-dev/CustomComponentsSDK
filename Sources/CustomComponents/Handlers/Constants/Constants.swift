//  Created by Alessandro Comparini on 02/09/23.
//

import Foundation


public struct K {
    public struct Default {
        public static let backgroundColor: String = "#ffffff"
        public static let padding: CGFloat = 8
        public static let paddingWithImage: CGFloat = 8
        public static let weight: K.Weight = .medium
        public static let fontSize: CGFloat = 14
        public static let imageSize: CGFloat = 14
    }

}


//  MARK: - EXTENSION - Images

extension K {
    public struct Images {
        static let eye = "eye"
        static let eyeSlash = "eye.slash"
        static let eraserLineDashed = "eraser.line.dashed"
        static let chevronBackward = "chevron.backward"
        static let chevronForward = "chevron.forward"
    }
}


//  MARK: - EXTENSION - Strings

extension K {
    public struct Strings {
        public static let empty = ""
        public static let done = "Done"
        public static let dot = "."
        public static let comma = ","
    }
}


//  MARK: - EXTENSION - Appearance

extension K {
    public enum Appearance: Int {
        case `default` = 0
        case dark = 1
        case light = 2
    }
}


//  MARK: - EXTENSION - Weight

extension K {
    public enum Weight: Int {
        case bold = 0
        case semibold = 1
        case regular = 2
        case ultraLight = 3
        case thin = 4
        case light = 5
        case medium = 6
        case heavy = 7
        case black = 8
    }
}


//  MARK: - EXTENSION - ContentMode

extension K {
    public enum ContentMode: Int {
        case scaleToFill = 0
        case scaleAspectFit = 1
        case scaleAspectFill = 2
        case redraw = 3
        case center = 4
        case top = 5
        case bottom = 6
        case left = 7
        case right = 8
        case topLeft = 9
        case topRight = 10
        case bottomLeft = 11
        case bottomRight = 12
    }
}


//  MARK: - EXTENSION - Position

extension K {
    public enum Position {
        case top
        case bottom
        case left
        case right
        case all

        public enum Vertical {
            case top
            case bottom
        }
        public enum Horizontal {
            case left
            case right
        }
    }
}


//  MARK: - EXTENSION - Text

extension K {
    public struct Text {
        public enum Alignment: Int {
            case left = 0
            case center = 1
            case right = 2
            case justified = 3
            case natural = 4
        }
        
        public enum AutocapitalizationType: Int {
            case none = 0
            case words = 1
            case sentences = 2
            case allCharacters = 3
        }
        
        public enum AutocorrectionType: Int {
            case `default` = 0
            case no = 1
            case yes = 2
        }
    }
}


//  MARK: - EXTENSION - Corner

extension K {
    public enum Corner {
        case leftTop
        case rightTop
        case leftBottom
        case rightBottom
        case top
        case bottom
        case left
        case right
        case diagonalUp
        case diagonalDown
    }
}


//  MARK: - EXTENSION - Shows Scroll

extension K {
    public enum ShowsScroll {
        case horizontal
        case vertical
        case both
    }
}


//  MARK: - EXTENSION - SeparatorStyle

extension K {
    public enum SeparatorStyle: Int {
        case none = 0
        case singleLine = 1
    }
}


//  MARK: - EXTENSION - Keyboard
extension K {
    public struct Keyboard {
        public enum `Types`: Int {
            case `default` = 0
            case asciiCapable = 1
            case numbersAndPunctuation = 2
            case URL = 3
            case numberPad = 4
            case phonePad = 5
            case namePhonePad = 6
            case emailAddress = 7
            case decimalPad = 8
            case twitter = 9
            case webSearch = 10
            case asciiCapableNumberPad = 11
        }
        
        public enum ReturnKeyType: Int {
            case `default` = 0
            case go = 1
            case google = 2
            case join = 3
            case next = 4
            case route = 5
            case search = 6
            case send = 7
            case yahoo = 8
            case done = 9
            case emergencyCall = 10
            case `continue` = 11
        }
        
        public enum SystemItem: Int {
            case done = 0
            case cancel = 1
            case edit = 2
            case save = 3
            case add = 4
            case flexibleSpace = 5
            case fixedSpace = 6
            case compose = 7
            case reply = 8
            case action = 9
            case organize = 10
            case bookmarks = 11
            case search = 12
            case refresh = 13
            case stop = 14
            case camera = 15
            case trash = 16
            case play = 17
            case pause = 18
            case rewind = 19
            case fastForward = 20
            case undo = 21
            case redo = 22
            case close = 24
        }
        
        public enum ContentType: String {
            case name = "name"
            case namePrefix = "namePrefix"
            case givenName = "givenName"
            case middleName = "middleName"
            case familyName = "familyName"
            case nameSuffix = "nameSuffix"
            case nickname = "nickname"
            case jobTitle = "jobTitle"
            case organizationName = "organizationName"
            case location = "location"
            case fullStreetAddress = "fullStreetAddress"
            case streetAddressLine1 = "streetAddressLine1"
            case streetAddressLine2 = "streetAddressLine2"
            case addressCity = "addressCity"
            case addressState = "addressState"
            case addressCityAndState = "addressCityAndState"
            case sublocality = "sublocality"
            case countryName = "countryName"
            case postalCode = "postalCode"
            case telephoneNumber = "telephoneNumber"
            case emailAddress = "emailAddress"
            case URL = "URL"
            case creditCardNumber = "creditCardNumber"
            case username = "username"
            case password = "password"
            case newPassword = "newPassword"
            case oneTimeCode = "oneTimeCode"
            case empty = ""
        }
    }
}


//  MARK: - EXTENSION - ActivityIndicator

extension K {
    public struct ActivityIndicator {
        public enum Style: Int {
            case medium = 100
            case large = 101
        }
    }
}


//  MARK: - EXTENSION - UISheetPresentationController

extension K {
    public struct SheetPresentationController {
        public enum Detent {
            case medium
            case large
        }
    }
}


//  MARK: - EXTENSION - Gradient

extension K {
    public struct Gradient {
        public enum Direction {
            case leftToRight
            case rightToLeft
            case topToBottom
            case bottomToTop
            case leftBottomToRightTop
            case leftTopToRightBottom
            case rightBottomToLeftTop
            case rightTopToLeftBottom
        }
    }
}


