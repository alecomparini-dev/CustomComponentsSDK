//  Created by Alessandro Comparini on 25/10/23.
//

import UIKit

@available(iOS 15.0, *)
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
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
    }
    
    
}

class CustomPresentationController: UIPresentationController {
    var customHeight: CGFloat = 0.7

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }

        // Defina a altura desejada (por exemplo, 70% da altura da tela)
        let desiredHeight = containerView.bounds.height * customHeight

        return CGRect(x: 0, y: containerView.bounds.height - desiredHeight, width: containerView.bounds.width, height: desiredHeight)
    }
}


@available(iOS 15.0, *)
extension BottomSheetBuilder: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = CustomPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
}
