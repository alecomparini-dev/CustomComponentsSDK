//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

@MainActor
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
    
    public func equalTo(_ relationElement: Any,  multiplier: CGFloat = 1, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, multiplier: multiplier, constant: constant)
        return startAutoLayout
    }
    
    public func equalTo(_ relationElement: BaseBuilder,  multiplier: CGFloat = 1, _ constant: CGFloat = 0) -> StartAutoLayout  {
        return equalTo(relationElement.baseView, multiplier: multiplier, constant)
    }

    public func greaterThanOrEqualTo(_ relationElement: Any, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set( relationBy: .greaterThanOrEqual, relationElement: relationElement, multiplier: multiplier, constant: constant)
        return startAutoLayout
    }

    public func lessThanOrEqualTo(_ relationElement: Any, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, relationElement: relationElement, multiplier: multiplier, constant: constant)
        return startAutoLayout
    }
    

    
    
//  MARK: - SAFEAREA
    public func equalToSafeArea(_ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, constant: constant)
        startAutoLayout.autoLayout.typeElement = .safeArea
        return startAutoLayout
    }
    
    public func greaterThanOrEqualToSafeArea(_ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, constant: constant)
        startAutoLayout.autoLayout.typeElement = .safeArea
        return startAutoLayout
    }
    
    public func lessThanOrEqualToSafeArea(_ constant: CGFloat = 0) -> StartAutoLayout  {
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
    
    public func greaterThanOrEqualToSuperview(_ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, constant: constant)
        startAutoLayout.autoLayout.typeElement = .superview
        return startAutoLayout
    }

    public func lessThanOrEqualToSuperview(_ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, constant: constant)
        startAutoLayout.autoLayout.typeElement = .superview
        return startAutoLayout
    }
        
}

