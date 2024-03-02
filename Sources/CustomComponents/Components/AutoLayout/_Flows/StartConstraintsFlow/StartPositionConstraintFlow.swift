//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit


public class StartPositionConstraintFlow<T> {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    
    
    //  MARK: - LAYOUT POSITION
    public var top: EndPositionConstraintFlow<T> {
        startAutoLayout.autoLayout.mainAttribute.append(.top)
        return EndPositionConstraintFlow<T>(startAutoLayout)
    }
    
    public var bottom: EndPositionConstraintFlow<T> {
        startAutoLayout.autoLayout.mainAttribute.append(.bottom)
        return EndPositionConstraintFlow<T>(startAutoLayout)
    }
    
    public var leading: EndPositionConstraintFlow<T> {
        startAutoLayout.autoLayout.mainAttribute.append(.leading)
        return EndPositionConstraintFlow<T>(startAutoLayout)
    }
    
    public var trailing: EndPositionConstraintFlow<T> {
        startAutoLayout.autoLayout.mainAttribute.append(.trailing)
        return EndPositionConstraintFlow<T>(startAutoLayout)
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
    
    public func equalTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, toAttribute: toAttribute, constant: constant)
        return startAutoLayout
    }
    
    public func greaterThanOrEqualTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, relationElement: relationElement, toAttribute: toAttribute, constant: constant)
        return startAutoLayout
    }
    
    public func lessThanOrEqualTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, relationElement: relationElement, toAttribute: toAttribute, constant: constant)
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
        startAutoLayout.autoLayout.typeElement = .superView
        return startAutoLayout
    }
    
    public func greaterThanOrEqualToSuperview(_ relationElement: Any, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, constant: constant)
        startAutoLayout.autoLayout.typeElement = .superView
        return startAutoLayout
    }

    public func lessThanOrEqualToSuperview(_ relationElement: Any, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, constant: constant)
        startAutoLayout.autoLayout.typeElement = .superView
        return startAutoLayout
    }

    
    
}
