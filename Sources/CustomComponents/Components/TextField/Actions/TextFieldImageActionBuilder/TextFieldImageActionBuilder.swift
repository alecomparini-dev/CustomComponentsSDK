
//  Created by Alessandro Comparini on 12/09/23.
//

import Foundation

@MainActor
public class TextFieldImageActionBuilder: TextFieldActionBuilder {
    public typealias tapImageTextField = (_ image: ImageViewBuilder) -> Void

    
    @discardableResult
    public func setTapImageLeft(_ closure: @escaping tapImageTextField) -> Self {
        guard let textFieldImage = component as? TextFieldImageBuilder,
            let imageViewLeft = textFieldImage.imageViewLeft else { return self}
        
        _ = ActionBuilder(component: imageViewLeft)
            .setTap({ tapGesture in
                closure(imageViewLeft)
            })
        
        return self
    }
    
    
    @discardableResult
    public func setTapImageRight(_ closure: @escaping tapImageTextField) -> Self {
        guard let textFieldImage = component as? TextFieldImageBuilder,
            let imageViewRight = textFieldImage.imageViewRight else { return self}
        
        _ = ActionBuilder(component: imageViewRight)
            .setTap({ tapGesture in
                closure(imageViewRight)
            })
        
        return self
    }
   
    
}
