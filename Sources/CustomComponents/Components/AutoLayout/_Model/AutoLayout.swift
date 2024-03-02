//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

public struct AutoLayout {
    public var mainElement: UIView
    public var mainAttribute: [NSLayoutConstraint.Attribute] = []
    public var relationBy: NSLayoutConstraint.Relation?
    public var typeElement: ConstraintsTypeElement?
    public var toItem: Any?
    public var toAttribute: NSLayoutConstraint.Attribute?
    public var multiplier: CGFloat
    public var constant: CGFloat

    public init(mainElement: UIView, mainAttribute: [NSLayoutConstraint.Attribute] = [], relationBy: NSLayoutConstraint.Relation? = nil, typeElement: ConstraintsTypeElement? = nil, toItem: Any? = nil, toAttribute: NSLayoutConstraint.Attribute? = nil, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        self.mainElement = mainElement
        self.mainAttribute = mainAttribute
        self.relationBy = relationBy
        self.typeElement = typeElement
        self.toItem = toItem
        self.toAttribute = toAttribute
        self.multiplier = multiplier
        self.constant = constant
    }
    
}
