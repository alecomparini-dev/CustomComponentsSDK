//  Created by Alessandro Comparini on 07/11/24.
//

import UIKit

@MainActor
public class RefreshControlBuilder: BaseBuilder, RefreshControl {
    public typealias T = UIRefreshControl
    
    public var get: UIRefreshControl { refreshControl }
    
    private let refreshControl: UIRefreshControl
    
//  MARK: - INITIALIZERS
    
    public init() {
        self.refreshControl = UIRefreshControl()
        super.init(refreshControl)
    }
    
    
//  MARK: - SET PROPERTIES
    
    public func setTextAttributed(_ text: String) -> Self {
        refreshControl.attributedTitle = NSAttributedString(string: text)
        return self
    }
    
    @discardableResult
    public func setTintColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        refreshControl.tintColor = color
        return self
    }
    
    public func setTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTintColor(UIColor.HEX(color))
        return self
    }

    
//  MARK: - PUBLIC AREA
    
    public func beginRefreshing() {
        refreshControl.beginRefreshing()
    }
    
    public func endRefreshing() {
        refreshControl.endRefreshing()
    }

    public func isRefresing() -> Bool {
        refreshControl.isRefreshing
    }

    
//  MARK: - SET ACTION
    public func setActions(action: (RefreshControlActionsBuilder) -> RefreshControlActionsBuilder) -> Self {
        _ = action(RefreshControlActionsBuilder(self))
        return self
    }

}
