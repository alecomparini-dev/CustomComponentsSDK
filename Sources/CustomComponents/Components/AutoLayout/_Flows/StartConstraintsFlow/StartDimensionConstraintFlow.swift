//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit


public class StartDimensionConstraintFlow<T> {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    

//  MARK: - CONSTRAINTS POSITION FLOW
    public var top: EndDimensionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.top)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    
    public var bottom: EndDimensionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.bottom)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    
    public var leading: EndDimensionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.leading)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    
    public var trailing: EndDimensionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.trailing)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    
    
    
//  MARK: - CONSTRAINTS SIZE FLOW
    public var width: Self {
        startAutoLayout.autoLayout.mainAttribute.append(.width)
        return self
    }
    
    public var height: Self {
        startAutoLayout.autoLayout.mainAttribute.append(.height)
        return self
    }
    
    
    
//  MARK: - EQUALTO CONSTANT

    public func equalToConstant(_ constant: CGFloat) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, constant: constant)
        return startAutoLayout
    }

    public func greaterThanOrEqualToConstant(_ constant: CGFloat) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, constant: constant)
        return startAutoLayout
    }

    public func lessThanOrEqualToConstant(_ constant: CGFloat) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, constant: constant)
        return startAutoLayout
    }

    
//  MARK: - EQUALTO
    
    public func equalTo(_ relationElement: Any, _ toAttribute: T, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
//        guard let toAttribute else {
//            guard let mainAttr = startAutoLayout.autoLayout.mainAttribute.last else {return startAutoLayout}
//            Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, toAttribute: mainAttr, multiplier: multiplier , constant: constant)
//            return startAutoLayout
//        }
        guard let toAttribute = toAttribute as? ConstraintsAttributeProtocol else {return startAutoLayout }
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, toAttribute: toAttribute.toConstraintsAttribute(), multiplier: multiplier, constant: constant)
        return startAutoLayout
    }
    
    public func equalTo(_ relationElement: Any, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, constant: constant)
        return startAutoLayout
    }
    
    public func greaterThanOrEqualTo(_ relationElement: Any, _ toAttribute: T, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
        guard let toAttribute = toAttribute as? ConstraintsAttributeProtocol else {return startAutoLayout }
        Constraints(startAutoLayout).set( relationBy: .greaterThanOrEqual, relationElement: relationElement, toAttribute: toAttribute.toConstraintsAttribute(), multiplier: multiplier, constant: constant)
        return startAutoLayout
    }

    
    public func lessThanOrEqualTo(_ relationElement: Any, _ toAttribute: T, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
        guard let toAttribute = toAttribute as? ConstraintsAttributeProtocol else {return startAutoLayout }
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, relationElement: relationElement, toAttribute: toAttribute.toConstraintsAttribute(), multiplier: multiplier, constant: constant)
        return startAutoLayout
    }
    

    
    
//  MARK: - SAFEAREA
    public func equalToSafeArea(_ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, constant: constant)
        startAutoLayout.autoLayout.typeElement = .safeArea
        return startAutoLayout
    }
    
    public func greaterThanOrEqualToSafeArea(_ relationElement: Any, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, constant: constant)
        startAutoLayout.autoLayout.typeElement = .safeArea
        return startAutoLayout
    }
    
    public func lessThanOrEqualToSafeArea(_ relationElement: Any, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, constant: constant)
        startAutoLayout.autoLayout.typeElement = .safeArea
        return startAutoLayout
    }
    
    
    
//  MARK: - SUPERVIEW
    public func equalToSuperview(_ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, constant: constant)
        startAutoLayout.autoLayout.typeElement = .superview
        return startAutoLayout
    }
    
    public func greaterThanOrEqualToSuperview(_ relationElement: Any, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, constant: constant)
        startAutoLayout.autoLayout.typeElement = .superview
        return startAutoLayout
    }

    public func lessThanOrEqualToSuperview(_ relationElement: Any, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, constant: constant)
        startAutoLayout.autoLayout.typeElement = .superview
        return startAutoLayout
    }
        
}

