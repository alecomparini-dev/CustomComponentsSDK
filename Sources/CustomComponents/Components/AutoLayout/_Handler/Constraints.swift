//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

struct Constraints {
    
    private let startAutoLayout: StartAutoLayout
    
    init(_ startAutoLayout: StartAutoLayout) {
        self.startAutoLayout = startAutoLayout
    }
    
    func set(relationBy: NSLayoutConstraint.Relation, relationElement: Any? = nil, toAttribute: NSLayoutConstraint.Attribute? = nil, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        guard let toAtt = setToAttribute(toAttribute) else {return}
        startAutoLayout.autoLayout.relationBy = .lessThanOrEqual
        startAutoLayout.autoLayout.toItem = relationElement
        startAutoLayout.autoLayout.toAttribute = toAtt
        startAutoLayout.autoLayout.multiplier = multiplier
        startAutoLayout.autoLayout.constant = constant
    }
    
    
    
//  MARK: - PRIVATE AREA
    
    private func setToAttribute(_ toAttribute: NSLayoutConstraint.Attribute?) -> NSLayoutConstraint.Attribute? {
        if let toAttribute { return toAttribute}
        
        guard let lastAttribute = startAutoLayout.autoLayout.mainAttribute.last else { return nil }
        
        return lastAttribute
    }
    
}

