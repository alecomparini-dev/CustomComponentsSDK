//
//  EndOfConstraintsPositionFlow.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

open class EndOfConstraintsPositionFlow: EndOfConstraintsPositionFlowProtocol {
    private let constraintVM: ConstraintsViewModel
    private let constraintsFlow: StartOfConstraintsFlow

    public init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        self.constraintVM = self.constraintsFlow.constraintVM
    }
    
    public var setTop: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.top)
        return self
    }
    
    public var setBottom: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.bottom)
        return self
    }
    
    public var setLeading: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.leading)
        return self
    }
    
    public var setTrailing: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.trailing)
        return self
    }
    
    
//  MARK: - CONSTRAINTS SIZE FLOW
    public var setWidth: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.width)
        return EndOfConstraintsSizeFlow(constraintsFlow)
    }
    
    public var setHeight: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.height)
        return EndOfConstraintsSizeFlow(constraintsFlow)
    }
    
    
//  MARK: - CONSTRAINTS RELATIONS

    public func equalTo(_ element: UIView, _ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalTo(element, constant)
        return constraintsFlow
    }
    
    public func equalTo(_ element: UIView) -> StartOfConstraintsFlow {
        constraintVM.equalTo(element)
        return constraintsFlow
    }

    public var equalToSafeArea: StartOfConstraintsFlow {
        constraintVM.equalToSafeArea()
        return constraintsFlow
    }
    
    public func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalToSafeArea(constant)
        return constraintsFlow
    }
    
    public var equalToSuperView: StartOfConstraintsFlow {
        constraintVM.equalToSuperView()
        return constraintsFlow
    }
    
    public func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalToSuperView(constant)
        return constraintsFlow
    }
    
}
