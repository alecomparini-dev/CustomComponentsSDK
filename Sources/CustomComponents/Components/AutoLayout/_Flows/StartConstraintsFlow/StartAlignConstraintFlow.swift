//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

@MainActor
public class StartAlignConstraintFlow<T> {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    
    
    
//  MARK: - CONSTRAINTS ALIGNMENTS
    
    var horizontalAlignX: EndAlignConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.horizontalX)
        return EndAlignConstraintFlow(startAutoLayout)
    }
    
    var verticalAlignY: EndAlignConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.verticalY)
        return EndAlignConstraintFlow(startAutoLayout)
    }
    
    
    
//  MARK: - CONSTRAINTS

    public func equalTo(_ relationElement: Any, _ toAttribute: T, _ constant: CGFloat = 0) -> StartAutoLayout  {
        guard let toAttribute = toAttribute as? ConstraintsAttributeProtocol else {return startAutoLayout }
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, toAttribute: toAttribute.toConstraintsAttribute(), constant: constant)
        return startAutoLayout
    }
    
    public func equalTo(_ relationElement: BaseBuilder, _ toAttribute: T, _ constant: CGFloat = 0) -> StartAutoLayout  {
        return equalTo(relationElement.baseView, toAttribute, constant)
    }
    
    public func greaterThanOrEqualTo(_ relationElement: Any, _ toAttribute: T? = nil, constant: CGFloat = 0) -> StartAutoLayout  {
        guard let toAttribute = toAttribute as? ConstraintsAttributeProtocol else {return startAutoLayout }
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, relationElement: relationElement, toAttribute: toAttribute.toConstraintsAttribute(), constant: constant)
        return startAutoLayout
    }

    public func lessThanOrEqualTo(_ relationElement: Any, _ toAttribute: T? = nil, constant: CGFloat = 0) -> StartAutoLayout  {
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
