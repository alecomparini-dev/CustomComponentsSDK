//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

public protocol ImageView {
    associatedtype T
    var get: T { get }
    
    func setImage(systemName: String) -> Self
    
    func setImage(named: String) -> Self
    
    func setContentMode(_ contentMode: K.ContentMode) -> Self
    
    func setTintColor(hexColor: String) -> Self
    
    func setSize(_ size: CGFloat) -> Self
    
    func setWeight(_ weight: K.Weight) -> Self
    
}
