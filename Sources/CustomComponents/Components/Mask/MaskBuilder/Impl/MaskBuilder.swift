//  Created by Alessandro Comparini on 16/10/23.
//

import Foundation

@MainActor
open class MaskBuilder: Mask {
    
    public typealias T = TLCustomMask
    public var get: TLCustomMask { self.tlCustomMask }
    
    private let tlCustomMask: TLCustomMask
    
    public init() {
        self.tlCustomMask = TLCustomMask()
    }

    
//  MARK: - GET PROPERTIES
    public func formatString(_ string: String) -> String {
        return tlCustomMask.formatString(string: string)
    }
    
    public func formatStringWithRange(range: NSRange, string: String) -> String {
        return tlCustomMask.formatStringWithRange(range: range, string: string)
    }
    
    public func cleanText(_ text: String) -> String {
        return tlCustomMask.cleanText(text)
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setCustomMask(_ mask: String) -> Self {
        tlCustomMask.formattingPattern = mask
        return self
    }
    
    @discardableResult
    public func setDateMask(_ abbreviatedYear: Bool = false) -> Self {
        if abbreviatedYear {
            tlCustomMask.formattingPattern = "$$/$$/$$"
            return self
        }
        tlCustomMask.formattingPattern = "$$/$$/$$$$"
        return self
    }
    
    @discardableResult
    public func setDateUniversalMask() -> Self {
        tlCustomMask.formattingPattern = "$$$$-$$-$$"
        return self
    }

    @discardableResult
    public func setHourMask() -> Self {
        tlCustomMask.formattingPattern = "$$:$$:$$"
        return self
    }

    @discardableResult
    public func setCPFMask() -> Self {
        tlCustomMask.formattingPattern = "$$$.$$$.$$$-$$"
        return self
    }
    
    @discardableResult
    public func setCEPMask() -> Self {
        tlCustomMask.formattingPattern = "$$$$$-$$$"
        return self
    }
    
    @discardableResult
    public func setCellPhoneNumberMask() -> Self {
        tlCustomMask.formattingPattern = "($$) $$$$$-$$$$"
        return self
    }


}


/*
 * CREDITS: https://github.com/Edudjr/TLCustomMask/blob/master/README.md
                        
                        MIT LICENSE
 Copyright (c) 2017 Edudjr <eduardo.djr@hotmail.com>

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 * CustomMask takes a string and returns it with the matching pattern
 * Usualy it is used inside the shouldChangeCharactersInRange method
 *
 *  usage:
 *   func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
 *      self.text = customMask!.formatStringWithRange(range, string: string)
 *      return false
 *   }
 *
 *  Use $ for digits ($$-$$$$)
 *  Use * for characters [a-zA-Z] (**-****)
 */

public class TLCustomMask {
    private var _formattingPattern : String;
    var finalText : String?
    private let digitChar : String = "$" //represents a digit
    private let alfaChar : String = "*" //represents an character
    public var cleanText : String {
        return alfanumericOnly(string: self.finalText!)
    }
    
    public var formattingPattern : String{
        get{return self._formattingPattern}
        set(newPattern){
            self._formattingPattern = newPattern
            //pass previous text to new pattern
            let text = formatString(string: alfanumericOnly(string: self.finalText!))
            self.finalText = text != "" ? addPatternToString(string: text) : newPattern
        }
    }
    
    fileprivate init(formattingPattern : String = ""){
        self._formattingPattern = formattingPattern;
        self.finalText = self._formattingPattern
    }
    
    
    public func cleanText(_ text: String) -> String {
        return alfanumericOnly(string: text)
    }
    
    /*
     * This approach is based on indexes that
     * will iterate independently on two arrays,
     * one for the pattern e.g: ["$","-","$"]
     * and one for the string e.g: ["1","a","2"]
     */
//    fileprivate func formatString(string: String) -> String{
    public func formatString(string: String) -> String{
        // if there is no pattern, return string
        if self._formattingPattern.isEmpty{
            return string
        }
        
        //Transform into arrays
        let patternArray = formattingPattern.map({$0})
        let stringArray = alfanumericOnly(string: string).map({$0})
        var finalTextArray: [Character] = []
        var patternArrayIndex = 0
        var stringArrayIndex = 0
        
        //iterate through string array
        loopStringArray: while stringArrayIndex < stringArray.count{
            //iterate through pattern array
            loopPatternArray: while patternArrayIndex < patternArray.count{
                switch patternArray[patternArrayIndex] {
                case "$":
                    //Check if Int
                    if let _ = Int(String(stringArray[stringArrayIndex])){
                        finalTextArray.append(stringArray[stringArrayIndex])
                    }else{
                        break loopPatternArray
                    }
                case "*":
                    //Check if character
                    //if matches
                    if matchesForRegexInText(regex: "[a-zA-Z]", text: String(stringArray[stringArrayIndex])).first != nil{
                        finalTextArray.append(stringArray[stringArrayIndex])
                    }else{
                        break loopPatternArray
                    }
                default:
                    finalTextArray.append(patternArray[patternArrayIndex])
                    patternArrayIndex += 1
                    continue loopStringArray
                }
                patternArrayIndex += 1
                break
            }
            stringArrayIndex += 1
        }
        
        //Add pattern to finalText and return string without pattern
        let textResult = String(finalTextArray)
        self.finalText = addPatternToString(string: textResult)
        
        return textResult
    }
    
    /*
     * This approach is based on regex
     * it will search for the first special character ($ or *)
     * and replace it with the user input e.g: 12-$$$$ -> 12-3$$$
     */
//    fileprivate func formatStringWithRange(range: NSRange, string: String) -> String {
    public func formatStringWithRange(range: NSRange, string: String) -> String {
        //Detect backspace
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) { //Backspace was pressed
            self.finalText = deleteLastChar()
        } 
        else {
            //Find index of first special character ($ or *)
            if let range = self.finalText!.range(of: "\\*|\\$", options: .regularExpression){
                let char = self.finalText?[range]
                if(char == "$"){
                    if let _ = Int(string){
                        self.finalText = self.finalText?.replacingCharacters(in: range, with: string)
                    }
                }
                else if(char == "*"){
                    //if matches
                    let matches = matchesForRegexInText(regex: "[a-zA-Z]", text: string)
                    if (matches.count > 0) {
                        self.finalText = self.finalText?.replacingCharacters(in: range, with: string)
                    }
                }
            }
        }
        
        //If empty
        if(self.finalText == self._formattingPattern){
            return ""
        }else{
            return removePatternFromString(string: self.finalText!)
        }
    }
    
    private func deleteLastChar() -> String{
        //find last char which is not the replacement char (the last thing that the user typed)
        let matches = matchesForRegexInText(regex: "[a-zA-Z0-9]((?=.*?\\*.*)|(?=.*?\\$.*))", text: self.finalText!)
        let ft = self.finalText!
        var replaceRange : Range<String.Index>? = nil
        var originalCharFromPattern : String? = nil
        
        //return empty if finalText is null
        if ft.isEmpty{
            return ""
        }
        
        //if match found
        if (matches.count > 0){
            let matchReplacementChar = matches.last
            replaceRange = self.finalText!.range(of: matchReplacementChar!, options: .backwards)
            originalCharFromPattern = String(self._formattingPattern[replaceRange!.lowerBound...replaceRange!.lowerBound])
        }
            //there is no match, consequently, formatting pattern is full: "123-66-1234" OR empty: "($$) $$$$-$$$$"
        else{
            //get last char from formatting pattern
            replaceRange = ft.range(of: ft[ft.index(before: ft.endIndex) ..< ft.endIndex], options: .backwards)
            originalCharFromPattern = String(self._formattingPattern[replaceRange!])
        }
        
        //Insert the pattern char back to the final string and return
        return ft.replacingCharacters(in: replaceRange!, with: originalCharFromPattern!)
    }
    
    
    /*
     * Cleans the string, removing the pattern
     * e.g: "123-4*-***" will return "123-4"
     */
//    private func removePatternFromString(string : String) -> String{
    public func removePatternFromString(string : String) -> String{
        //let matches = regMatchGroup("-?((\\*.*)|(\\$.*))", text: self.finalText!)
        let matches = matchesForRegexInText(regex: "((-)|(\\()|(\\)))?(\\*.*)|(\\$.*)", text: self.finalText!)
        var finalString = string
        var matchStr : String? = nil
        
        if (matches.count > 0){
            matchStr = matches[0]
            finalString = string.replacingOccurrences(of: matchStr!, with: "")
        }
        return finalString
    }
    
    /*
     * Add pattern to string
     * e.g: "123-4" will return "123-4*-***"
     */
    private func addPatternToString(string : String) -> String{
        if let range = string.range(of: string){
            var result = ""
            //If range exists in self.formattingPattern
            if range.upperBound <= self.formattingPattern.endIndex {
                result = self.formattingPattern.replacingCharacters(in: range, with: string)
            }
            return result
        }
        return self._formattingPattern
    }
    
    private func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    /*
     * Checks if pattern is valid
     * TODO: improve this
     */
    private func checkValidPattern(pattern: String){
        let matches = matchesForRegexInText(regex: "[^\\$|\\*|\\-|\\.]", text: pattern)
        if(matches.count > 0){
            print("Warning: not a valid pattern for CustomMask!");
        }
    }
    
    /*
     * Returns alfanumeric string only
     */
    private func alfanumericOnly(string: String) -> String{
        return string.stringByRemovingRegexMatches(pattern: "\\W")
    }
    
}

extension String {
    func stringByRemovingRegexMatches(pattern: String, replaceWith: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return self
        }
    }
}
