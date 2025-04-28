//
//  EndOfConstraintsSizeFlow.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

open class EndOfConstraintsSizeFlow: EndOfConstraintsSizeFlowProtocol {
    private let constraintVM: ConstraintsViewModel
    private let constraintsFlow: StartOfConstraintsFlow

    public init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        self.constraintVM = self.constraintsFlow.constraintVM
    }

    
//  MARK: - CONSTRAINTS POSITION FLOW
    public var setTop: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.top)
        return self
    }
    
    public var setBottom: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.bottom)
        return self
    }
    
    public var setLeading: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.leading)
        return self
    }
    
    public var setTrailing: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.trailing)
        return self
    }
    
    
//  MARK: - CONSTRAINTS SIZE FLOW
    public var setWidth: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.width)
        return self
    }
    
    public var setHeight: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.height)
        return self
    }
    
    
//  MARK: - CONSTRAINTS RELATIONS
    
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
