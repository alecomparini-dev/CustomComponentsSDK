
//  Created by Alessandro Comparini on 12/09/23.
//

import Foundation

@MainActor
public class TextFieldImageActionBuilder: ActionBuilder {
    public typealias tapImageTextField = (_ image: ImageViewBuilder) -> Void
    
    private weak var component: TextFieldImageBuilder?
    
    public init(_ component: TextFieldImageBuilder) {
        self.component = component
        super.init(component: component)
    }
    
    deinit {
        component = nil
    }
    
    @discardableResult
    public func setTapImageLeft(_ closure: @escaping tapImageTextField) -> Self {
        guard let imageViewLeft = component?.imageViewLeft else { return self}
        _ = ActionBuilder(component: imageViewLeft)
            .setTap({ tapGesture in
                closure(imageViewLeft)
            })
        return self
    }
    
    
    public func setTapImageRight(_ closure: @escaping tapImageTextField) -> Self {
        guard let imageViewRight = component?.imageViewRight else { return self}
        _ = ActionBuilder(component: imageViewRight)
            .setTap({ tapGesture in
                closure(imageViewRight)
            })
        return self
    }
   
    
}
