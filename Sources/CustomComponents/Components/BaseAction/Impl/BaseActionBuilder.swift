//  Created by Alessandro Comparini on 12/09/23.
//

import Foundation

public class BaseActionBuilder: BaseAction {
    
//    private weak var component: BaseBuilder?
    private var component: BaseBuilder?
    
    init(component: BaseBuilder) {
        self.component = component
    }
    
    @discardableResult
    public func setTouch(_ closure: @escaping touchBaseActionAlias, _ cancelsTouchesInView: Bool = true) -> Self {
        guard let component else {return self}
        TapGestureBuilder(component)
            .setCancelsTouchesInView(cancelsTouchesInView)
            .setTap { tapGesture in
                closure(component, tapGesture)
            }
        
        return self
    }
    
    
}
