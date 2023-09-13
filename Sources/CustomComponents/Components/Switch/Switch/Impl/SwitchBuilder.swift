//  Created by Alessandro Comparini on 12/09/23.
//

import UIKit

open class SwitchBuilder: BaseBuilder, Switch {
    public typealias T = UISwitch
    public var get: UISwitch { self.switchView }
    
    private var switchView: UISwitch
    
    
//  MARK: - INITIALIZERS
    public init(isOn: Bool) {
        self.switchView = UISwitch()
        super.init(switchView)
        setIsOn(isOn)
    }
    
    public convenience init() {
        self.init(isOn: false)
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setIsOn(_ isOn: Bool) -> Self {
        switchView.setOn(isOn, animated: true)
        return self
    }
    
    @discardableResult
    public func setOnTintColor(hexColor: String) -> Self {
        switchView.onTintColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setTintColor(hexColor: String) -> Self {
        switchView.tintColor = UIColor.HEX(hexColor)
        return self
    }
    
    @discardableResult
    public func setThumbTintColor(hexColor: String) -> Self {
        switchView.thumbTintColor = UIColor.HEX(hexColor)
        return self
    }
    
}
