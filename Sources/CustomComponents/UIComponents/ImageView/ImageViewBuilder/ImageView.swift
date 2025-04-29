//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

@MainActor
public protocol ImageView {
    associatedtype T
    var get: T { get }
    
    func setImage(systemName: String) -> Self
    
    func setImage(systemName: [String]) -> Self
    
    func setImage(named: String) -> Self
    
    func setContentMode(_ contentMode: UIK.ContentMode) -> Self
    
    func setTintColor(hexColor color: String?) -> Self
    
    func setTintColor(named color: String?) -> Self
    
    func setSize(_ size: CGFloat) -> Self
    
    func setWeight(_ weight: UIK.Weight) -> Self
    
}
