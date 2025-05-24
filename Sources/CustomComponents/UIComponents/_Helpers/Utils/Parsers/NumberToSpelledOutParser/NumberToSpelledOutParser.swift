//  Created by Alessandro Comparini on 24/05/25.
//

final public class NumberToSpelledOutParser {
    
    public static func parse(_ number: Int) throws -> String {
        guard number >= 0 && number <= 999 else { throw NumberToSpelledOutParserError.outOfRange }
        
        if number < 10 {
            return UNIT_SPELLED_OUT["\(number)"]!
        }
        
        if number < 20 {
            return COMPOUND_TEN_SPELLED_OUT["\(number)"]!
        }
        
        if number < 100 {
            let dezena = (number / 10) * 10
            let unidade = number % 10
            if unidade == 0 {
                return TEN_SPELLED_OUT["\(dezena)"]!
            }
            return "\(TEN_SPELLED_OUT["\(dezena)"]!) e \(UNIT_SPELLED_OUT["\(unidade)"]!)"
        }
        
        if number == 100 {
            return "\(HUNDRED_SPELLED_OUT["\(number)"]!)"
        }
        
        let centena = (number / 100) * 100
        
        let resto = number % 100
        
        let texto = centena == 100 ? "cento" : HUNDRED_SPELLED_OUT["\(centena)"]!
        
        if resto == 0 {
            return texto
        }
        
        return "\(texto) e \(try parse(resto))"
    }
    
}
