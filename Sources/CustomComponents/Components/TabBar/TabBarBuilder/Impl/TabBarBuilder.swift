//  Created by Alessandro Comparini on 26/09/23.
//

import UIKit

public struct TabBarItems {
    public let viewController: UIViewController
    public let image: ImageViewBuilder
    public let title: String?
    
    public init(viewController: UIViewController, image: ImageViewBuilder, title: String? = nil) {
        self.viewController = viewController
        self.image = image
        self.title = title
    }
}

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
    public func setTintColor(color: UIColor?) -> Self {
        guard let color else {return self}
        tabBar.tabBar.tintColor = color
        return self
    }
    
    @discardableResult
    public func setTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTintColor(color: UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setUnselectedItemTintColor(color: UIColor?) -> Self {
        guard let color else {return self}
        tabBar.tabBar.unselectedItemTintColor = color
        return self
    }
    
    @discardableResult
    public func setUnselectedItemTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setUnselectedItemTintColor(color: UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setIsNavigationBarHidden(_ flag: Bool) -> Self {
        tabBar.navigationController?.isNavigationBarHidden = flag
        return self
    }
}
