//  Created by Alessandro Comparini on 02/09/23.
//

import Foundation

public struct K {

    public struct Default {
        public static let padding: CGFloat = 8
        public static let paddingWithImage: CGFloat = 12
        public static let weight: K.Weight = .regular
    }
    
    public struct String {
        public static let empty = ""
    }
    
    public enum Appearance: Int {
        case `default` = 0
        case dark = 1
        case light = 2
    }
    
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
    
    public struct Position {
        public enum Vertical {
            case top
            case bottom
        }
        public enum Horizontal {
            case left
            case right
        }
        public enum All {
            case top
            case bottom
            case left
            case right
        }
    }
    
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
    
    public struct Keyboard {
        public enum `Type`: Int {
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
        
        
    }
    
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
