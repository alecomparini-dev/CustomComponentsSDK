//
//  File.swift
//  
//
//  Created by Alessandro Comparini on 12/09/23.
//

import Foundation

public protocol Switch {
    associatedtype T
    var get: T { get }
    
    func setIsOn(_ flag: Bool) -> Self
    
    func setOnTintColor(hexColor: String?) -> Self
    
    func setOnTintColor(named color: String?) -> Self
    
    func setThumbTintColor(hexColor color: String?) -> Self
    
    func setThumbTintColor(named color: String?) -> Self
    
    
}
