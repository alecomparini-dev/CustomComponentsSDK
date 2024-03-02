//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

public class StartAlignConstraintFlow {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    
    
    
//  MARK: - CONSTRAINTS ALIGNMENTS
    
    var horizontalAlignX: EndAlignConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.centerX)
        return EndAlignConstraintFlow(startAutoLayout)
    }
    
    var verticalAlignY: EndAlignConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.centerY)
        return EndAlignConstraintFlow(startAutoLayout)
    }
    
    
    
//  MARK: - CONSTRAINTS

    public func equalTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, toAttribute: toAttribute, multiplier: multiplier, constant: constant)
        return startAutoLayout
    }
    
    public func greaterThanOrEqualTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, relationElement: relationElement, toAttribute: toAttribute, multiplier: multiplier, constant: constant)
        return startAutoLayout
    }

    public func lessThanOrEqualTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, relationElement: relationElement, toAttribute: toAttribute, multiplier: multiplier, constant: constant)
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
