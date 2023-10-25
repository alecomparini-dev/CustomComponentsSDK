//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

@available(iOS 15.0, *)
open class BottomSheetsBuilder: BottomSheets {
    
    private var sheet: UISheetPresentationController?
    
    private let viewController: UIViewController
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
        configure()
    }
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setDetents(_ detent: K.SheetPresentationController.Detent) -> Self {
        switch detent {
        case .medium:
            sheet?.detents.append(.medium())
        case .large:
            sheet?.detents.append(.large())
        }
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
