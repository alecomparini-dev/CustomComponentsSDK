//  Created by Alessandro Comparini on 26/09/23.
//

import UIKit

open class ViewControllerBuilder: ViewController {
    public typealias T = UIViewController
    public var get: T { self.viewController }
    
    private var viewController: UIViewController
    
    public init() {
        self.viewController = UIViewController(nibName: nil, bundle: nil)
    }
    
}
