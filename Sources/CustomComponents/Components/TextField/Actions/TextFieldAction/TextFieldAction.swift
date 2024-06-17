//  Created by Alessandro Comparini on 17/06/24.
//

import Foundation

import Foundation

@MainActor
public class TextFieldAction: ActionBuilder {
    
    private(set) weak var component: TextFieldBuilder?
    
    public init(_ component: TextFieldBuilder) {
        self.component = component
        super.init(component: component)
    }
    
    deinit {
        component = nil
    }
    
    
//  MARK: - SET PROPERTIES
    
    
}
