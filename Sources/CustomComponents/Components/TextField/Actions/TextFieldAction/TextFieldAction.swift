//  Created by Alessandro Comparini on 17/06/24.
//

import UIKit

@MainActor
public class TextFieldAction: ActionBuilder {
    public typealias textFieldEditing = (_ image: ImageViewBuilder) -> Void
    
    private(set) weak var component: TextFieldBuilder?
    
    public init(_ component: TextFieldBuilder) {
        self.component = component
        super.init(component: component)
    }
    
    deinit {
        component = nil
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setTarget(_ target: Any, _ action: Selector , _ event: UIControl.Event) -> Self {
        component?.get.addTarget(target, action: action, for: event)
        return self
    }

}


