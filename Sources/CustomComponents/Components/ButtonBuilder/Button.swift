//
//  File.swift
//  
//
//  Created by Alessandro Comparini on 02/09/23.
//

import Foundation

protocol Button {
    associatedtype T
    var button: T { get }
    
    @discardableResult
    func setTitle(_ title: String) -> Self

    @discardableResult
    func setTitleColor(_ hexColor: String) -> Self
    
    @discardableResult
    func setTintColor(_ hexColor: String) -> Self
    
    @discardableResult
    func setTextAlignment(_ textAlignment: Constants.TextAlignment) -> Self
    
    @discardableResult
    func setFontFamily(_ fontFamily: String, _ fontSize: CGFloat ) -> Self
    
    @discardableResult
    func setTitleSize(_ fontSize: CGFloat ) -> Self
    
    @discardableResult
    func setTitleWeight(_ weight: Constants.Weight ) -> Self
    
}
