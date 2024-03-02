//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

public class AutoLayout {
    public var mainElement: UIView
    public var mainAttribute:[ConstraintsAttribute] = []
    public var relationBy: NSLayoutConstraint.Relation?
    public var typeElement: ConstraintsTypeElement?
    public var toItem: Any?
    public var toAttribute: ConstraintsAttribute? = nil
    public var multiplier: CGFloat
    public var constant: CGFloat

    public init(mainElement: UIView, mainAttribute: [ConstraintsAttribute] = [], relationBy: NSLayoutConstraint.Relation? = nil, typeElement: ConstraintsTypeElement? = nil, toItem: Any? = nil, toAttribute: ConstraintsAttribute? = nil, multiplier: CGFloat = 1, constant: CGFloat = 0) {
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
