//
//  StartOfConstraintsSizeFlow.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit
	

class StartOfConstraintsSizeFlow: StartOfConstraintsSizeFlowProtocol {
    private let constraintVM: ConstraintsViewModel
    private let constraintsFlow: StartOfConstraintsFlow

    init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        self.constraintVM = self.constraintsFlow.constraintVM
    }
    
    
//  MARK: - CONSTRAINTS POSITION FLOW
    var setTop: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.top)
        return EndOfConstraintsSizeFlow(constraintsFlow)
    }
    
    var setBottom: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.bottom)
        return EndOfConstraintsSizeFlow(constraintsFlow)
    }
    
    var setLeading: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.leading)
        return EndOfConstraintsSizeFlow(constraintsFlow)
    }
    
    var setTrailing: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.trailing)
        return EndOfConstraintsSizeFlow(constraintsFlow)
    }
    
    
//  MARK: - CONSTRAINTS SIZE FLOW
    
    var setWidth: StartOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.width)
        return StartOfConstraintsSizeFlow(constraintsFlow)
    }
    
    var setHeight: StartOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.height)
        return StartOfConstraintsSizeFlow(constraintsFlow)
    }
    
    
//  MARK: - CONSTRAINTS RELATIONS

    func equalTo(_ element: UIView) -> StartOfConstraintsFlow {
        constraintVM.equalTo(element)
        return constraintsFlow
    }
    
    func lessThanOrEqualTo(_ element: UIView) -> StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualTo(element)
        return constraintsFlow
    }

    func greaterThanOrEqualTo(_ element: UIView) -> StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualTo(element)
        return constraintsFlow
    }

    
//  MARK: - CONSTRAINTS RELATIONS CONSTANT
    
    func equalToConstant(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalToConstant(constant)
        return constraintsFlow
    }
    
    func lessThanOrEqualToConstant(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToConstant(constant)
        return constraintsFlow
    }
    
    func greaterThanOrEqualToConstant(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToConstant(constant)
        return constraintsFlow
    }
    
    
//  MARK: - SAFE AREA
    
    var equalToSafeArea: StartOfConstraintsFlow {
        constraintVM.equalToSafeArea()
        return constraintsFlow
    }
    
    func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalToSafeArea(constant)
        return constraintsFlow
    }
    
    var greaterThanOrEqualToSafeArea: StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSafearea()
        return constraintsFlow
    }
    
    func greaterThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSafearea(constant)
        return constraintsFlow
    }
    
    var lessThanOrEqualToSafeArea: StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToSafearea()
        return constraintsFlow
    }
    
    func lessThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToSafearea(constant)
        return constraintsFlow
    }
    
    
//  MARK: - SUPER VIEW
    var equalToSuperview: StartOfConstraintsFlow {
        constraintVM.equalToSuperview()
        return constraintsFlow
    }
    
    func equalToSuperview(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalToSuperview(constant)
        return constraintsFlow
    }
    
    var greaterThanOrEqualToSuperview: StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSuperview()
        return constraintsFlow
    }
    
    func greaterThanOrEqualToSuperview(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSuperview(constant)
        return constraintsFlow
    }
    
    var lessThanOrEqualToSuperview: StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToSuperview()
        return constraintsFlow
    }
    
    func lessThanOrEqualToSuperview(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToSuperview(constant)
        return constraintsFlow
    }
    
    
}
