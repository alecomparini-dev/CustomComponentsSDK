//
//  File.swift
//  
//
//  Created by Alessandro Comparini on 22/11/23.
//

import Foundation

public struct ExecThreadMain {
    
    public func exec(_ completion: @escaping () -> Void ) {
        if Thread.isMainThread {
            completion()
            return
        }
        DispatchQueue.main.async {
            completion()
        }
    }
    
}

