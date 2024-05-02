//  Created by Alessandro Comparini on 23/04/24.
//

import Foundation

open class SwitchButtonBuilder: BaseBuilder, SwitchButton {
    
    public var get: ViewBuilder { switchButton }
    

//  MARK: - INITIALIZERS
    
    private let switchButton: ViewBuilder
    
    public init() {
        self.switchButton = ViewBuilder()
        super.init(switchButton.get)
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setViewLeft(_ view: ViewBuilder) -> Self {
        return self
    }
    
    @discardableResult
    public func setViewRight(_ view: ViewBuilder) -> Self {
        return self
    }
    

    
    
}
