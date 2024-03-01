//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

public struct AutoLayout {
    //    var constraint = NSLayoutConstraint(item: UIView(),
    //                                        attribute: .top,
    //                                        relatedBy: .equal,
    //                                        toItem: nil,
    //                                        attribute: .bottom,
    //                                        multiplier: 1,
    //                                        constant: 0)
    //
    public var mainElement: UIView?
    public var mainAttribute: [NSLayoutConstraint.Attribute]?
    public var relationBy: NSLayoutConstraint.Relation?
    public var toItem: Any?
    public var toAttribute: NSLayoutConstraint.Attribute?
    public var multiplier: CGFloat
    public var constant: CGFloat

    public init(mainElement: UIView? = nil, mainAttribute: [NSLayoutConstraint.Attribute]? = nil, relationBy: NSLayoutConstraint.Relation? = nil, toItem: Any? = nil, toAttribute: NSLayoutConstraint.Attribute? = nil, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        self.mainElement = mainElement
        self.mainAttribute = mainAttribute
        self.relationBy = relationBy
        self.toItem = toItem
        self.toAttribute = toAttribute
        self.multiplier = multiplier
        self.constant = constant
    }
    
}



//  MARK: - StartAutoLayout
public class StartAutoLayout {
    private var listAutoLayout = [AutoLayout]()
    var autoLayout: AutoLayout
    
    public init(element: UIView) {
        self.autoLayout = AutoLayout()
        autoLayout.mainElement = element
        listAutoLayout.append(self.autoLayout)
    }
    
    public var top: StartPositionConstraintFlow<ConstraintsPositionY> {
        autoLayout.mainAttribute?.append(.top)
        return StartPositionConstraintFlow<ConstraintsPositionY>(self)
    }
    
    public var bottom: StartPositionConstraintFlow<ConstraintsPositionY> {
        autoLayout.mainAttribute?.append(.bottom)
        return StartPositionConstraintFlow<ConstraintsPositionY>(self)
    }
    
}


//  MARK: - StartPositionConstraintFlow
public class StartPositionConstraintFlow<T> {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
        
    public var top: EndPositionConstraintFlow<ConstraintsPositionY> {
        startAutoLayout.autoLayout.mainAttribute?.append(.top)
        return EndPositionConstraintFlow<ConstraintsPositionY>(startAutoLayout)
    }
    
    public var bottom: EndPositionConstraintFlow<ConstraintsPositionY> {
        startAutoLayout.autoLayout.mainAttribute?.append(.bottom)
        return EndPositionConstraintFlow<ConstraintsPositionY>(startAutoLayout)
    }

    public var leading: EndPositionConstraintFlow<ConstraintsPositionX> {
        startAutoLayout.autoLayout.mainAttribute?.append(.top)
        return EndPositionConstraintFlow<ConstraintsPositionX>(startAutoLayout)
    }
    
    public var trailing: EndPositionConstraintFlow<ConstraintsPositionX> {
        startAutoLayout.autoLayout.mainAttribute?.append(.bottom)
        return EndPositionConstraintFlow<ConstraintsPositionX>(startAutoLayout)
    }

    
    
}

//  MARK: - EndPositionConstraintFlow
public class EndPositionConstraintFlow<T> {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }

    public var top: Self {
        startAutoLayout.autoLayout.mainAttribute?.append(.top)
        return self
    }
    
    public var bottom: Self {
        startAutoLayout.autoLayout.mainAttribute?.append(.top)
        return self
    }
    
    public var leading: Self {
        startAutoLayout.autoLayout.mainAttribute?.append(.leading)
        return self
    }
    
    public var trailing: Self {
        startAutoLayout.autoLayout.mainAttribute?.append(.trailing)
        return self
    }

    
//  MARK: - CONSTRAINTS SIZE FLOW
    public var width: EndDimensionConstraintFlow<T> {
        startAutoLayout.autoLayout.mainAttribute?.append(.width)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    
    public var height: EndDimensionConstraintFlow<T> {
        startAutoLayout.autoLayout.mainAttribute?.append(.height)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    
}






public class StartDimensionConstraintFlow<T> {
    private var startAutoLayout: StartAutoLayout
    
    public init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    

//  MARK: - CONSTRAINTS POSITION FLOW
    public var top: EndDimensionConstraintFlow<T> {
        startAutoLayout.autoLayout.mainAttribute?.append(.top)
        return EndDimensionConstraintFlow<T>(startAutoLayout)
    }
    
    public var bottom: EndDimensionConstraintFlow<T> {
        startAutoLayout.autoLayout.mainAttribute?.append(.bottom)
        return EndDimensionConstraintFlow<T>(startAutoLayout)
    }
    
    public var leading: EndDimensionConstraintFlow<T> {
        startAutoLayout.autoLayout.mainAttribute?.append(.leading)
        return EndDimensionConstraintFlow(startAutoLayout)
    }
    
    public var trailing: EndDimensionConstraintFlow<T> {
        startAutoLayout.autoLayout.mainAttribute?.append(.trailing)
        return EndDimensionConstraintFlow<T>(startAutoLayout)
    }
    
    
    
//  MARK: - CONSTRAINTS SIZE FLOW
    public var width: Self {
        startAutoLayout.autoLayout.mainAttribute?.append(.width)
        return self
    }
    
    public var height: Self {
        startAutoLayout.autoLayout.mainAttribute?.append(.height)
        return self
    }
    
    
    
//  MARK: - CONSTRAINTS RELATIONS

    public func equalToConstant(_ constant: CGFloat) -> StartAutoLayout  {
        guard let toAttribute = startAutoLayout.autoLayout.mainAttribute?.last else { return startAutoLayout }
        Constraints(startAutoLayout).set(relationBy: .equal, toAttribute: toAttribute, constant: constant)
        return startAutoLayout
    }

    public func greaterThanOrEqualToConstant(_ constant: CGFloat) -> StartAutoLayout  {
        guard let toAttribute = startAutoLayout.autoLayout.mainAttribute?.last else { return startAutoLayout }
        Constraints(startAutoLayout).set(relationBy: .greaterThanOrEqual, toAttribute: toAttribute, constant: constant)
        return startAutoLayout
    }

    public func lessThanOrEqualToConstant(_ constant: CGFloat) -> StartAutoLayout  {
        guard let toAttribute = startAutoLayout.autoLayout.mainAttribute?.last else { return startAutoLayout }
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, toAttribute: toAttribute, constant: constant)
        return startAutoLayout
    }
    
    public func equalTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .equal, relationElement: relationElement, toAttribute: toAttribute, multiplier: multiplier, constant: constant)
        return startAutoLayout
    }
    
    public func greaterThanOrEqualTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set( relationBy: .greaterThanOrEqual, relationElement: relationElement, toAttribute: toAttribute, multiplier: multiplier, constant: constant)
        return startAutoLayout
    }

    
    public func lessThanOrEqualTo(_ relationElement: Any, _ toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1, constant: CGFloat = 0) -> StartAutoLayout  {
        Constraints(startAutoLayout).set(relationBy: .lessThanOrEqual, relationElement: relationElement, toAttribute: toAttribute, multiplier: multiplier, constant: constant)
        return startAutoLayout
    }
        
}


struct Constraints {
    private let startAutoLayout: StartAutoLayout
    
    init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    
    func set(relationBy: NSLayoutConstraint.Relation, relationElement: Any? = nil, toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        startAutoLayout.autoLayout.relationBy = .lessThanOrEqual
        startAutoLayout.autoLayout.toItem = relationElement
        startAutoLayout.autoLayout.toAttribute = toAttribute
        startAutoLayout.autoLayout.multiplier = multiplier
        startAutoLayout.autoLayout.constant = constant
    }
    
}







