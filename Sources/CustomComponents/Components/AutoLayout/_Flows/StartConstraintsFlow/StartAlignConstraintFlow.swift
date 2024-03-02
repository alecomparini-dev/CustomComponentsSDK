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
    
    
}
