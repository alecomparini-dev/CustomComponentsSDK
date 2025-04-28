//  Created by Alessandro Comparini on 11/10/23.
//

import UIKit

@MainActor
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
