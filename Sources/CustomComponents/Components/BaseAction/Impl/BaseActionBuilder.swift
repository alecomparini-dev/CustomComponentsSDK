//  Created by Alessandro Comparini on 12/09/23.
//

import Foundation

public class BaseActionBuilder: BaseAction {
    
    private weak var component: BaseBuilder?
    
    private var tap = [touchBaseActionAlias]()
    
    init(component: BaseBuilder) {
        self.component = component
    }
    
    @discardableResult
    public func setTap(_ closure: @escaping touchBaseActionAlias, _ cancelsTouchesInView: Bool = true) -> Self {
        guard let component else {return self}
        self.tap.append(closure)
        self.setTapGesture { build in
            build
                .setCancelsTouchesInView(cancelsTouchesInView)
                .setTap { tapGesture in
                    closure(component, tapGesture)
                }
        }
        return self
    }

    
    @discardableResult
    public func setTapGesture(_ build: (_ build: TapGestureBuilder) -> TapGestureBuilder) -> Self {
        guard let component else {return self}
        _ = build(TapGestureBuilder(component.baseView))
        return self
    }
    
}

