//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit


public class StartPositionConstraintFlow<T> {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    
    
    //  MARK: - LAYOUT POSITION
    public var top: EndPositionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.top)
        return EndPositionConstraintFlow(startAutoLayout)
    }
    
    public var bottom: EndPositionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.bottom)
        return EndPositionConstraintFlow(startAutoLayout)
    }
    
    public var leading: EndPositionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.leading)
        return EndPositionConstraintFlow(startAutoLayout)
    }
    
    public var trailing: EndPositionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.trailing)
        return EndPositionConstraintFlow(startAutoLayout)
    }
    
    
    //  MARK: - LAYOUT DIMENSION
    
    public var width: EndDimensionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.width)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    
    public var height: EndDimensionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.height)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    
    
    //  MARK: - CONSTRAINTS
    
    public func equalTo(_ relationElement: Any, _ toAttribute: T? = nil, constant: CGFloat = 0) -> StartAutoLayout  {
        guard let toAttribute = toAttribute as? ConstraintsAttributeProtocol else {return startAutoLayout }
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, toAttribute: toAttribute.toConstraintsAttribute(), constant: constant)
        return startAutoLayout
    }
        
    public func greaterThanOrEqualTo(_ relationElement: Any, _ toAttribute: T, _ constant: CGFloat = 0) -> StartAutoLayout  {
        guard let toAttribute = toAttribute as? ConstraintsAttributeProtocol else {return startAutoLayout }
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, relationElement: relationElement, toAttribute: toAttribute.toConstraintsAttribute(), constant: constant)
        return startAutoLayout
    }
    
    public func lessThanOrEqualTo(_ relationElement: Any, _ toAttribute: T, _ constant: CGFloat = 0) -> StartAutoLayout  {
        guard let toAttribute = toAttribute as? ConstraintsAttributeProtocol else {return startAutoLayout }
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, relationElement: relationElement, toAttribute: toAttribute.toConstraintsAttribute(), constant: constant)
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
