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
        public static let eye = "eye"
        public static let eyeSlash = "eye.slash"
        public static let chevronBackward = "chevron.backward"
        public static let chevronForward = "chevron.forward"
        public static let xCircleFill = "x.circle.fill"
        public static let eraser = ["eraser.line.dashed", "clear"]
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


//  MARK: - EXTENSION - Axis

extension K {
    public enum Axis: Int {
        case horizontal = 0
        case vertical = 1
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
            case both
        }
    }
}


//  MARK: - EXTENSION - Text

extension K {
    public struct TextField {
        public enum ViewMode: Int{
            case never = 0
            case whileEditing = 1
            case unlessEditing = 2
            case always = 3
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
        
        public enum ContentHorizontalAlignment : Int {
            case center = 0
            case left = 1
            case right = 2
            case fill = 3
            case leading = 4
            case trailing = 5
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
        
        public enum Identifiers: String {
            case gradientID = "gradientID"
        }
        
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

//  MARK: - EXTENSION - Skeleton
extension K {
    public struct Skeleton {
        public enum SpeedAnimation {
            case slow
            case medium
            case fast
        }
    }
}



//  MARK: - EXTENSION - Skeleton
extension K {
    public struct StackView {
        public enum Distribution : Int {
            case fill = 0
            case fillEqually = 1
            case fillProportionally = 2
            case equalSpacing = 3
            case equalCentering = 4
        }
        
        public enum Alignment : Int {
            case fill = 0
            case leading = 1
            case firstBaseline = 2
            case center = 3
            case trailing = 4
            case lastBaseline = 5
            case top
            case bottom
        }
    }
}

//  MARK: - EXTENSION - Neumorphism
extension K {
    public struct Neumorphism {
    
        public struct Strings {
            public static let distance = "distance"
            public static let blur = "blur"
            public static let intensity = "intensity"
        }
        
        public enum Identifiers: String {
            case darkShadowID = "DARK_SHADOW_ID"
            case lightShadowID = "LIGHT_SHADOW_ID"
            case shapeID = "SHAPE_ID"
        }
        
        public enum Shadow {
            case light
            case dark
        }
        
        public enum Shape {
            case flat
            case concave
            case convex
            case pressed
            case none
        }
        
        public enum LightPosition {
            case leftTop
            case leftBottom
            case rightTop
            case rightBottom
        }
        
        public enum Percentage: CGFloat {
            case lightShadowColor = 60
            case darkShadowColor = -85
            case lightShapeColorByColorReference = 70
            case darkShapeColorByColorReference = -30
        }
        
    }
}

//  MARK: - EXTENSION - Button
extension K {
    public struct Button {
        
        public static let zPosition: CGFloat = 1000
        
        public struct Interaction {
            public static let shadowOpacityProperty = "shadowOpacity"
        }
    }
}

//  MARK: - EXTENSION - Dropdown

extension K {
    public struct Dropdown {
        public static let zPosition: CGFloat = 1000
    }
}


//  MARK: - EXTENSION - Modal

extension K {
    public struct Modal {
        public static let zPosition: CGFloat = 1100
    }
}


//  MARK: - EXTENSION - Dock
extension K {
    public struct Dock {
        
        public struct Default {
            public static let cellSize = CGSize(width: 50, height: 50)
        }
        
        public enum ScrollPosition {
            case none
            case top
            case centeredVertically
            case bottom
            case left
            case centeredHorizontally
            case right
        }
    }
}

//  MARK: - EXTENSION - Map
extension K {
    public struct Map {
        
        public enum UserTrackingMode: Int {
            case none = 0
            case follow = 1
            case followWithHeading = 2
        }

    }
}


//  MARK: - EXTENSION - List
extension K {
    public struct List {
        
        public enum Style : Int {
            case plain = 0
            case grouped = 1
            case insetGrouped = 2
        }
        
    }
}


