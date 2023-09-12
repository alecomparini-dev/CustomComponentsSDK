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
    
}
