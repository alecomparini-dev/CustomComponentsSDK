//  Created by Alessandro Comparini on 26/09/23.
//

import UIKit

@MainActor
public class TabBarBuilder: TabBar {
    public typealias T = UITabBarController
    
    private var itemsBar: [TabBarItems] = []
    
    public var get: UITabBarController { self.tabBar }
    private var tabBar: UITabBarController
    
    
//  MARK: - INITIALIZERS
    public init() {
        self.tabBar = UITabBarController(nibName: nil, bundle: nil)
    }
                                         
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setItems(items: [TabBarItems]) -> Self {
        var controllers: [UIViewController] = []
        items.forEach { item in
            controllers.append(item.viewController)
        }
        tabBar.setViewControllers(controllers, animated: true)
        
        items.enumerated().forEach { (index,item) in
            tabBar.tabBar.items?[index].title = item.title
            tabBar.tabBar.items?[index].image = item.image.get.image
        }
        return self
    }

    @discardableResult
    public func setTranslucent(_ flag: Bool) -> Self {
        tabBar.tabBar.isTranslucent = flag
        return self
    }
    
    @discardableResult
    public func setTintColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        tabBar.tabBar.tintColor = color
        return self
    }
    
    @discardableResult
    public func setTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTintColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setBackGroundColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        tabBar.tabBar.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func setBackGroundColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setBackGroundColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setUnselectedItemTintColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        tabBar.tabBar.unselectedItemTintColor = color
        return self
    }
    
    @discardableResult
    public func setUnselectedItemTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setUnselectedItemTintColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setIsNavigationBarHidden(_ flag: Bool) -> Self {
        tabBar.navigationController?.isNavigationBarHidden = flag
        return self
    }
}
