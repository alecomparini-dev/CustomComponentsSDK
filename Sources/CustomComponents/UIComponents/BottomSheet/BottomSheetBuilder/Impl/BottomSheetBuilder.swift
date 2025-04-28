//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

@available(iOS 15.0, *)
@MainActor
open class BottomSheetBuilder: NSObject, BottomSheet {
    
    private var sheet: UISheetPresentationController?
    
    private let viewController: UIViewController
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
        configure()
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setDetents(_ detents: [K.SheetPresentationController.Detent]) -> Self {
        sheet?.detents = detents.map({ detent in
            switch detent {
            case .medium:
                return UISheetPresentationController.Detent.medium()
            case .large:
                return UISheetPresentationController.Detent.large()
            }
        })
        return self
    }
    
    @discardableResult
    public func setScrollingExpandsWhenScrolledToEdge(_ flag: Bool) -> Self {
        sheet?.prefersScrollingExpandsWhenScrolledToEdge = flag
        return self
    }
    
    @discardableResult
    public func setGrabbervisible(_ flag: Bool) -> Self {
        sheet?.prefersGrabberVisible = flag
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ radius: CGFloat) -> Self {
        sheet?.preferredCornerRadius = radius
        return self
    }
    
    @discardableResult
    public func setLargestUndimmedDetentIdentifier(_ detent: K.SheetPresentationController.Detent?) -> Self {
        switch detent {
            case .medium:
                sheet?.largestUndimmedDetentIdentifier = .medium
            case .large:
                sheet?.largestUndimmedDetentIdentifier = .large
            case .none:
                sheet?.largestUndimmedDetentIdentifier = .none
        }
        
        return self
    }

    
    
//  MARK: - DELEGATE
    @discardableResult
    public func setDelegate(_ delegate: UISheetPresentationControllerDelegate) -> Self {
        sheet?.delegate = delegate
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        self.sheet = viewController.sheetPresentationController
        setGrabbervisible(true)
    }

}
