//
//  StartOfConstraintsPositionFlow.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

open class StartOfConstraintsPositionFlow<C>: StartOfConstraintsPositionFlowProtocol {
    public typealias T = C
    
    
    private let constraintVM: ConstraintsViewModel
    private let constraintsFlow: StartOfConstraintsFlow

    public init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        self.constraintVM = self.constraintsFlow.constraintVM
    }
    
    
//  MARK: - CONSTRAINTS POSITION FLOW
    
    public var setTop: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.top)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    public var setBottom: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.bottom)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    public var setLeading: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.leading)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    public var setTrailing: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.trailing)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }

    
//  MARK: - CONSTRAINTS SIZE FLOW
    
    public var setWidth: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.width)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    public var setHeight: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.height)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }

    
//  MARK: - CONSTRAINTS RELATIONS CONSTANT
    
    public func equalTo(_ element: UIView, _ attribute: T , _ constant: CGFloat) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.equalTo(element, attribute.toConstraintsAttribute() , constant)
        }
        return constraintsFlow
    }
    
    public func equalTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.equalTo(element, attribute.toConstraintsAttribute())
        }
        return constraintsFlow
    }
    
    public func lessThanOrEqualTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.lessThanOrEqualTo(element, attribute.toConstraintsAttribute() , constant)
        }
        return constraintsFlow
    }
    
    public func lessThanOrEqualTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.lessThanOrEqualTo(element, attribute.toConstraintsAttribute())
        }
        return constraintsFlow
    }
    
    
    public func greaterThanOrEqualTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.greaterThanOrEqualTo(element, attribute.toConstraintsAttribute() , constant)
        }
        return constraintsFlow
    }
    
    public func greaterThanOrEqualTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.greaterThanOrEqualTo(element, attribute.toConstraintsAttribute())
        }
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
    
    public var greaterThanOrEqualToSafeArea: StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSafearea()
        return constraintsFlow
    }
    
    public func greaterThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSafearea(constant)
        return constraintsFlow
    }
    
    public var lessThanOrEqualToSafeArea: StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToSafearea()
        return constraintsFlow
    }
    
    public func lessThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToSafearea(constant)
        return constraintsFlow
    }
    
    
//  MARK: - SUPER VIEW AREA
    public var equalToSuperView: StartOfConstraintsFlow {
        constraintVM.equalToSuperView()
        return constraintsFlow
    }
    
    public func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalToSuperView(constant)
        return constraintsFlow
    }
    
    
    public var greaterThanOrEqualToSuperView: StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSuperView()
        return constraintsFlow
    }
    
    public func greaterThanOrEqualToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSuperView(constant)
        return constraintsFlow
    }
    
    
    public var lessThanOrEqualToSuperView: StartOfConstraintsFlow{
        constraintVM.lessThanOrEqualToSuperView()
        return constraintsFlow
    }
    
    public func lessThanOrEqualToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToSuperView(constant)
        return constraintsFlow
    }
    
    
    
    
}



