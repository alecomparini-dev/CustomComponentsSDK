//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

extension UIViewController {
    
    @available(iOS 15.0, *)
    @discardableResult
    public func setBottomSheet(_ build: (_ build: BottomSheetsBuilder) -> BottomSheetsBuilder) -> Self {
        _ = build(BottomSheetsBuilder(viewController: self))
        return self
    }
    
    
}
