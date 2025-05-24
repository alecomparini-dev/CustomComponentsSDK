//  Created by Alessandro Comparini on 24/05/25.
//


public enum TextToDecimalParserError: Error, CustomStringConvertible {
    case invalidCentsSum
    case invalidFormat
    case outOfRange
    
    public var description: String {
        switch self {
        case .invalidCentsSum:
            return "A soma dos centavos ultrapassa 99."
        case .invalidFormat:
            return "Formato de entrada inválido."
        case .outOfRange:
            return "Fora do Intervalor."
        }
    }
}
