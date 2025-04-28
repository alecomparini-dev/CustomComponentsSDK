//  Created by Alessandro Comparini on 07/11/24.
//

import UIKit

@MainActor
public class RefreshControlActionsBuilder: ActionBuilder {
    
    private weak var component: RefreshControlBuilder?
    
    public init(_ component: RefreshControlBuilder) {
        self.component = component
        super.init(component: component)
    }

    
//  MARK: - ACTIONS AREA
    
    @discardableResult
    public func setTarget(_ target: Any, _ action: Selector , _ event: UIControl.Event = .valueChanged) -> Self {
        component?.get.addTarget(target, action: action, for: event )
        return self
    }
    
}
