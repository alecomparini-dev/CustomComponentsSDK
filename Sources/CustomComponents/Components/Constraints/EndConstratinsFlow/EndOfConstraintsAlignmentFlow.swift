//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

open class EndOfConstraintsAlignmentFlow: EndOfConstraintsAlignmentFlowProtocol {
    private let constraintVM: ConstraintsViewModel
    private let constraintsFlow: StartOfConstraintsFlow

    public init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        self.constraintVM = self.constraintsFlow.constraintVM
    }
    
    public func equalTo(_ element: UIView) -> StartOfConstraintsFlow {
        constraintVM.equalTo(element)
        return constraintsFlow
    }
    
    public var equalToSafeArea: StartOfConstraintsFlow {
        constraintVM.equalToSafeArea()
        return constraintsFlow
    }
    
    public var equalToSuperview: StartOfConstraintsFlow {
        constraintVM.equalToSuperview()
        return constraintsFlow
    }
    
}
