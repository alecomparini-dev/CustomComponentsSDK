//  Created by Alessandro Comparini on 25/10/23.
//

import Foundation

@MainActor
public protocol BottomSheet {
    
    func setDetents(_ detents: [UIK.SheetPresentationController.Detent]) -> Self
    
    func setScrollingExpandsWhenScrolledToEdge(_ flag: Bool) -> Self
    
    func setGrabbervisible(_ flag: Bool) -> Self
    
    func setCornerRadius(_ radius: CGFloat) -> Self
    
    func setLargestUndimmedDetentIdentifier(_ detent: UIK.SheetPresentationController.Detent?) -> Self
    
}

