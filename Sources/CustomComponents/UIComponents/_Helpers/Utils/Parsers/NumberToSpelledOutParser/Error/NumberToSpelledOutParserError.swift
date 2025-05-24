//  Created by Alessandro Comparini on 24/05/25.
//

enum NumberToSpelledOutParserError: Error, CustomStringConvertible {
    case outOfRange
    
    var description: String {
        switch self {
        case .outOfRange:
            return "Fora do Intervalo."
        }
    }
}
