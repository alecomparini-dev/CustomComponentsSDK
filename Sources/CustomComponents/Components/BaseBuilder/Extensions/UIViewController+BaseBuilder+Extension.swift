//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

@MainActor
extension UIViewController {
    
    @available(iOS 15.0, *)
    @discardableResult
    public func setBottomSheet(_ build: (_ build: BottomSheetBuilder) -> BottomSheetBuilder) -> Self {
        _ = build(BottomSheetBuilder(viewController: self))
        return self
    }
    
    
}
