//  Created by Alessandro Comparini on 27/10/23.
//

import Foundation


public protocol FormatterNumber {
    
    func formatter(double: Double) -> String?
//    func formatter(string: String) -> Double
    
    func getLocaleAvailable() -> [String]
    
    @discardableResult
    func setMinimumFractionDigits(_ minimum: Int) -> Self
    
    @discardableResult
    func setMaximumFractionDigits(_ max: Int) -> Self
    
    @discardableResult
    func setNumberStyle(_ style: NumberFormatter.Style) -> Self
    
    @discardableResult
    func setLocale(_ locale: String) -> Self
    
    @discardableResult
    func setCurrentLocale() -> Self
            
    
}

//en_US: Inglês (Estados Unidos)
//en_GB: Inglês (Reino Unido)
//fr_FR: Francês (França)
//es_ES: Espanhol (Espanha)
//de_DE: Alemão (Alemanha)
//it_IT: Italiano (Itália)
//ja_JP: Japonês (Japão)
//pt_BR: Português (Brasil)
//Locale.availableIdentifiers
