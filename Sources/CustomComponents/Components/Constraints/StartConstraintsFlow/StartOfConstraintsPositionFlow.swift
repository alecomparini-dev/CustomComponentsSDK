//
//  StartOfConstraintsPositionFlow.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

open class StartOfConstraintsPositionFlow<C>: StartOfConstraintsPositionFlowProtocol {
    public typealias T = C
    
    private var constraintVM: ConstraintsViewModel
    private weak var constraintsFlow: StartOfConstraintsFlow?

    public init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        if let constraintsFlow = self.constraintsFlow {
            self.constraintVM = constraintsFlow.constraintVM
        }
        self.constraintVM = ConstraintsViewModel()
    }
    
    
//  MARK: - CONSTRAINTS POSITION FLOW
    
    public var setTop: EndOfConstraintsPositionFlowProtocol {
        guard let constraintsFlow else { return EndOfConstraintsPositionFlow(StartOfConstraintsFlow(UIView()))}
        constraintVM.mainAttribute(.top)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    public var setBottom: EndOfConstraintsPositionFlowProtocol {
        guard let constraintsFlow else { return EndOfConstraintsPositionFlow(StartOfConstraintsFlow(UIView()))}
        constraintVM.mainAttribute(.bottom)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    public var setLeading: EndOfConstraintsPositionFlowProtocol {
        guard let constraintsFlow else { return EndOfConstraintsPositionFlow(StartOfConstraintsFlow(UIView()))}
        constraintVM.mainAttribute(.leading)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    public var setTrailing: EndOfConstraintsPositionFlowProtocol {
        guard let constraintsFlow else { return EndOfConstraintsPositionFlow(StartOfConstraintsFlow(UIView()))}
        constraintVM.mainAttribute(.trailing)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }

    
//  MARK: - CONSTRAINTS SIZE FLOW
    
    public var setWidth: EndOfConstraintsPositionFlowProtocol {
        guard let constraintsFlow else { return EndOfConstraintsPositionFlow(StartOfConstraintsFlow(UIView()))}
        constraintVM.mainAttribute(.width)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    public var setHeight: EndOfConstraintsPositionFlowProtocol {
        guard let constraintsFlow else { return EndOfConstraintsPositionFlow(StartOfConstraintsFlow(UIView()))}
        constraintVM.mainAttribute(.height)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }

    
//  MARK: - CONSTRAINTS RELATIONS CONSTANT
    
    public func equalTo(_ element: UIView, _ attribute: T , _ constant: CGFloat) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.equalTo(element, attribute.toConstraintsAttribute() , constant)
        }
        return constraintsFlow
    }
    
    public func equalTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.equalTo(element, attribute.toConstraintsAttribute())
        }
        return constraintsFlow
    }
    
    public func lessThanOrEqualTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.lessThanOrEqualTo(element, attribute.toConstraintsAttribute() , constant)
        }
        return constraintsFlow
    }
    
    public func lessThanOrEqualTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.lessThanOrEqualTo(element, attribute.toConstraintsAttribute())
        }
        return constraintsFlow
    }
    
    
    public func greaterThanOrEqualTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.greaterThanOrEqualTo(element, attribute.toConstraintsAttribute() , constant)
        }
        return constraintsFlow
    }
    
    public func greaterThanOrEqualTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.greaterThanOrEqualTo(element, attribute.toConstraintsAttribute())
        }
        return constraintsFlow
    }
    
    
    public var equalToSafeArea: StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.equalToSafeArea()
        return constraintsFlow
    }
    
    public func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.equalToSafeArea(constant)
        return constraintsFlow
    }
    
    public var greaterThanOrEqualToSafeArea: StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.greaterThanOrEqualToSafearea()
        return constraintsFlow
    }
    
    public func greaterThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.greaterThanOrEqualToSafearea(constant)
        return constraintsFlow
    }
    
    public var lessThanOrEqualToSafeArea: StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.lessThanOrEqualToSafearea()
        return constraintsFlow
    }
    
    public func lessThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.lessThanOrEqualToSafearea(constant)
        return constraintsFlow
    }
    
    
//  MARK: - SUPER VIEW AREA
    public var equalToSuperView: StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.equalToSuperView()
        return constraintsFlow
    }
    
    public func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.equalToSuperView(constant)
        return constraintsFlow
    }
    
    
    public var greaterThanOrEqualToSuperView: StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.greaterThanOrEqualToSuperView()
        return constraintsFlow
    }
    
    public func greaterThanOrEqualToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.greaterThanOrEqualToSuperView(constant)
        return constraintsFlow
    }
    
    
    public var lessThanOrEqualToSuperView: StartOfConstraintsFlow{
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.lessThanOrEqualToSuperView()
        return constraintsFlow
    }
    
    public func lessThanOrEqualToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        guard let constraintsFlow else { return StartOfConstraintsFlow(UIView())}
        constraintVM.lessThanOrEqualToSuperView(constant)
        return constraintsFlow
    }
    
    
    
    
}



