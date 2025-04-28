//  Created by Alessandro Comparini on 27/02/24.
//

import Foundation

@MainActor
public protocol ClearButtonMode {
    
    func setSizeButton(_ size: CGSize) -> Self
    
    func setPosition(_ position: K.Position.Horizontal) -> Self 
    
    func setImgButton(_ systemName: String) -> Self
    
    func setCompletion(_ completion: @escaping () -> Void) -> Self
    
    func apply() -> Self
    
}
