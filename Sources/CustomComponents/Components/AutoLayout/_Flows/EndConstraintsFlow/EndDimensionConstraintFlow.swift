//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

public class EndDimensionConstraintFlow {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    

//  MARK: - LAYOUT POSITION
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
    
    
//  MARK: - LAYOUT DIMENSION
    public var width: Self {
        startAutoLayout.autoLayout.mainAttribute.append(.width)
        return self
    }
    
    public var height: Self {
        startAutoLayout.autoLayout.mainAttribute.append(.height)
        return self
    }
    
    
//  MARK: - CONSTRAINTS

    public func equalTo(_ relationElement: Any, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, constant: constant)
        return startAutoLayout
    }
    
    public func greaterThanOrEqualTo(_ relationElement: Any, _ constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, relationElement: relationElement, constant: constant)
        return startAutoLayout
    }

    public func lessThanOrEqualTo(_ relationElement: Any, _ constant: CGFloat = 0) -> StartAutoLayout  {
        guard let toAttribute = startAutoLayout.autoLayout.mainAttribute.last else {return startAutoLayout}
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, relationElement: relationElement, constant: constant)
        return startAutoLayout
    }
    


    
}
