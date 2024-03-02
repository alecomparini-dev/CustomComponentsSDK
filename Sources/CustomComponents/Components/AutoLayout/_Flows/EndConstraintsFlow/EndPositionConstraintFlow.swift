//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit


public class EndPositionConstraintFlow<T> {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }

    public var top: Self {
        startAutoLayout.autoLayout.mainAttribute.append(.top)
        return self
    }
    
    public var bottom: Self {
        startAutoLayout.autoLayout.mainAttribute.append(.bottom)
        return self
    }
    
    public var leading: Self {
        startAutoLayout.autoLayout.mainAttribute.append(.leading)
        return self
    }
    
    public var trailing: Self {
        startAutoLayout.autoLayout.mainAttribute.append(.trailing)
        return self
    }
    

    
//  MARK: - CONSTRAINTS SIZE FLOW
    public var width: EndDimensionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.width)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    
    public var height: EndDimensionConstraintFlow {
        startAutoLayout.autoLayout.mainAttribute.append(.height)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    

//  MARK: - CONSTRAINTS

    public func equalTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, toAttribute: toAttribute, constant: constant)
        return startAutoLayout
    }
    
    public func greaterThanOrEqualTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, relationElement: relationElement, toAttribute: toAttribute, constant: constant)
        return startAutoLayout
    }

    public func lessThanOrEqualTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, relationElement: relationElement, toAttribute: toAttribute, constant: constant)
        return startAutoLayout
    }

    
}
