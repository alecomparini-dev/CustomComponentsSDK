//
//  File.swift
//  
//
//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

public protocol ImageView {
    
    func setImage(systemName: String) -> Self
    
    func setImage(named: String) -> Self
    
    func setContentMode(_ contentMode: UIView.ContentMode) -> Self
    
    func setTintColor(hexColor: String) -> Self
    
    func setSize(_ size: CGFloat) -> Self
    
    func setWeight(_ weight: K.Weight) -> Self
    
}
