//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

public class EndAlignConstraintFlow {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    
    
    
//  MARK: - CONSTRAINTS

    public func equalTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute ) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, toAttribute: toAttribute)
        return startAutoLayout
    }
    
    public func greaterThanOrEqualTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, relationElement: relationElement, toAttribute: toAttribute)
        return startAutoLayout
    }

    public func lessThanOrEqualTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, relationElement: relationElement, toAttribute: toAttribute)
        return startAutoLayout
    }
    
    
}

