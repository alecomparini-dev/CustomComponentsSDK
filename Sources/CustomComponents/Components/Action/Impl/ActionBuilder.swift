//  Created by Alessandro Comparini on 12/09/23.
//

import UIKit

public class ActionBuilder: Action {
    public typealias T = UIView
    
    private weak var component: T?
        
    public init(component: T) {
        self.component = component
    }
    
    public init(component: BaseBuilder) {
        self.component = component.baseView
    }
    
    @discardableResult
    public func setTap(_ closure: @escaping touchBaseActionAlias, _ cancelsTouchesInView: Bool = true) -> Self {
        guard let component else { return self }
        self.setTapGesture { build in
            build
                .setCancelsTouchesInView(cancelsTouchesInView)
                .setTap { [weak self] tapGesture in
                    guard let self else {return}
                    closure(component, tapGesture)
                }
        }
        return self
    }

    @discardableResult
    public func setTapGesture(_ build: (_ build: TapGestureBuilder) -> TapGestureBuilder) -> Self {
        guard let component else { return self }
        _ = build(TapGestureBuilder(component))
        return self
    }
    
}

