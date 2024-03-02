//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

struct Constraints {
    
    private let startAutoLayout: StartAutoLayout
    
    init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    
    func set(relationBy: NSLayoutConstraint.Relation, relationElement: Any? = nil, toAttribute: ConstraintsAttribute? = nil, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        startAutoLayout.autoLayout.relationBy = relationBy
        startAutoLayout.autoLayout.toItem = relationElement
        startAutoLayout.autoLayout.toAttribute = toAttribute
        startAutoLayout.autoLayout.multiplier = multiplier
        startAutoLayout.autoLayout.constant = constant
    }
    

}

