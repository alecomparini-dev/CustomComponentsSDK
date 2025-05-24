import Foundation

final public class TextToDecimalParser {
    
    public static func parse(_ text: String) throws -> Decimal? {
        if let _ = Double(text.trimmingCharacters(in: .whitespacesAndNewlines)) {
            return (Decimal(string: text.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0)
        }
        
        var words = text.lowercased().components(separatedBy: " ")
        
        words.removeAll { $0 == "e" }
        
        words = try convertNumberToSpelledOut(words)
        
        let parseFlow = decideParseFlow(words)
        
        switch parseFlow {
            case .hasReal:
                return try hasRealFlow(words)
            case .hasOnlyCents:
                return hasOnlyCentsFlow(words)
            case .hasNoRealOrCents:
                return hasNoRealOrCentsFlow(words)
            case .none:
                throw TextToDecimalParserError.invalidFormat
        }
    }
    
    
//  MARK: - PRIVATE AREA
    
    private static func convertNumberToSpelledOut(_ words: [String]) throws -> [String] {
        var updatedWords: [String] = []
        
        for word in words {
            if let number = Int(word) {
                var extenso = try NumberToSpelledOutParser.parse(number).components(separatedBy: " ")
                extenso.removeAll { $0 == "e" }
                updatedWords.append(contentsOf: extenso)
            } else {
                updatedWords.append(word)
            }
        }
        
        return updatedWords
    }
    
    private static func decideParseFlow(_ words: [String]) -> ParseFlow {
        let hasReal: Bool = words.contains(where: { TextToDecimalK.Strings.real.contains($0) })
        
        let hasCents: Bool = words.contains(where: { TextToDecimalK.Strings.cents.contains($0) })
        
        if hasReal { return .hasReal }
        
        if !hasReal && hasCents { return .hasOnlyCents }
        
        if !hasReal && !hasCents { return .hasNoRealOrCents }
        
        return .none
    }
    
    private static func hasNextIndex(_ index: Int , _ words: [String]) -> Bool { index < words.count - 1 }
    
    private static func convertTextToNumber(_ text: String) -> (type: NumberPartType, value: Int)? {
        let text = text.lowercased()
        
        if let number = UNIT[text]  { return (.unit, number) }
        
        if let number = COMPOUND_TEN[text] { return (.compoundTen, number) }
        
        if let number = TEN[text] { return (.ten, number) }
        
        if let number = HUNDRED[text] { return (.hundred, number) }
        
        return nil
    }
    
    private static func sumRealAndCents(_ indexReal: Int , _ text: [String]) -> Decimal? {
        let realWords = Array(text[0..<indexReal+1])
        
        let centavoWords = Array( text[(indexReal+1)..<text.endIndex])
        
        let sumReal = realWords.reduce(0) { partialResult, text in
            guard let number = convertTextToNumber(text) else { return 0 }
            return partialResult + number.value
        }
        
        let sumCents = centavoWords.reduce(0) { partialResult, text in
            guard let number = convertTextToNumber(text) else { return 0 }
            return partialResult + number.value
        }
        
        return (Decimal(string: "\(sumReal)\(String(format: "%02d", sumCents))") ?? 0) / 100
    }
    
//  MARK: - HAS REAL FLOW
    
    private static func hasRealFlow(_ text: [String]) throws -> Decimal? {
        var text = text
        
        guard let indexReal = text.firstIndex(where: { $0 == "real" || $0 == "reais" }) else {
            throw TextToDecimalParserError.invalidFormat
        }
        
        text.removeAll { TextToDecimalK.Strings.real.contains($0) ||
                         TextToDecimalK.Strings.cents.contains($0) }
        
        return sumRealAndCents(indexReal - 1, text)
    }

    
//  MARK: - HAS ONLY CENTS FLOW
    
    private static func hasOnlyCentsFlow(_ words: [String]) -> Decimal? {
        var words = words
        
        words.removeAll { TextToDecimalK.Strings.cents.contains($0) }
        
        var numbers = [Int]()
        
        for (index, word) in words.enumerated().reversed() {
            
            guard let number = convertTextToNumber(word) else { return 0}
            
            numbers.append(number.value)
            
            if number.type == .unit {
                if index == 0 { return (Decimal(string: "\(number.value)") ?? 0) / 100}
                
                guard let beforeNumber = convertTextToNumber(words[index-1]) else { return nil }
                
                numbers.append(beforeNumber.value)
                
                if beforeNumber.type != .ten { return sumRealAndCents(index-1, words) }
                
                return sumRealAndCents(index-2, words)
            }
            
            if number.type == .compoundTen { return sumRealAndCents(index-1, words) }
            
            if number.type == .ten {
                if index == 0 { return (Decimal(string: "\(number.value)") ?? 0) / 100 }
                
                return sumRealAndCents(index-1, words)
            }
        }
        
        return nil
    }
    
    
//  MARK: - HAS NO REAL OR CENTS FLOW
    
    private static func hasNoRealOrCentsFlow(_ words: [String]) -> Decimal? {
        var numbers = [Int]()
        
        for (index, text) in words.enumerated() {
            
            guard let number = convertTextToNumber(text) else { return nil }
            
            numbers.append(number.value)
            
            if number.type == .unit || number.type == .compoundTen {
                return sumRealAndCents(index, words)
            }
            
            if number.type == .ten {
                if !hasNextIndex(index, words) {
                    let total = numbers.reduce(0, +)
                    return (Decimal(string: "\(total)") ?? 0)
                }
                
                guard let nextNumber = convertTextToNumber(words[index + 1]) else { return nil }
                
                if nextNumber.type == .ten || nextNumber.type == .compoundTen {
                    return sumRealAndCents(index, words)
                }
            }
            
            if number.type == .hundred {
                if text == "cem" {
                    return sumRealAndCents(index, words)
                }
                
                if !hasNextIndex(index, words) {
                    let total = numbers.reduce(0, +)
                    return (Decimal(string: "\(total)") ?? 0)
                }
            }
        }
        
        return nil
    }
    
    
    
}
