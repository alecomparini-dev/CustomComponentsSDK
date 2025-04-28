
//  Created by Alessandro Comparini on 15/06/24.
//

import UIKit

@MainActor
public class ButtonActionsBuilder: ActionBuilder {
    
    private weak var component: ButtonBuilder?
    
    public init(_ component: ButtonBuilder) {
        self.component = component
        super.init(component: component)
    }

    
//  MARK: - ACTIONS AREA
    
    @discardableResult
    public func setTarget(_ target: Any, _ action: Selector , _ event: UIControl.Event) -> Self {
        component?.get.addTarget(target, action: action, for: event )
        return self
    }
    
}
