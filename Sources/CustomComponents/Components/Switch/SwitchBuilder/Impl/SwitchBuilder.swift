//  Created by Alessandro Comparini on 12/09/23.
//

import UIKit

@MainActor
open class SwitchBuilder: BaseBuilder, Switch {
    public typealias T = UISwitch
    public var get: UISwitch { self.switchView }
    
    private var switchView: UISwitch
    
    
//  MARK: - INITIALIZERS
    
    public init() {
        self.switchView = UISwitch()
        super.init(switchView)
    }

    public convenience init(isOn: Bool) {
        self.init()
        self.setIsOn(isOn)
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setIsOn(_ isOn: Bool) -> Self {
        switchView.setOn(isOn, animated: true)
        return self
    }
    
    @discardableResult
    public func setOnTintColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        switchView.onTintColor = color
        return self
    }
    
    @discardableResult
    public func setOnTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setOnTintColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setOnTintColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setOnTintColor(namedColor)
        return self
    }
    
    @discardableResult
    public func setThumbTintColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        switchView.thumbTintColor = color
        return self
    }
    
    @discardableResult
    public func setThumbTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setThumbTintColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setThumbTintColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setThumbTintColor(namedColor)
        return self
    }
    
}
