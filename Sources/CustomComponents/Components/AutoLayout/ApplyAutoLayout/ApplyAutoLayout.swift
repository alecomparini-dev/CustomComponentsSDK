//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

class ApplyAutoLayout {
    private var listAutoLayout = [AutoLayout]()

    init(_ listAutoLayout: [AutoLayout]) {
        self.listAutoLayout = listAutoLayout
    }
    
    func apply() {
        listAutoLayout.forEach { layout in
            layout.mainElement.translatesAutoresizingMaskIntoConstraints = false
            
            validateElementIsAdded(layout.mainElement)
            
            decideWitchConstraintToCall(layout)
        }
        
        listAutoLayout.removeAll()
    }
    
    private func decideWitchConstraintToCall(_ layout: AutoLayout) {
        layout.mainAttribute.forEach { mainAttr in
            activateConstraint(layout, mainAttr)
        }
    }
    
    private func activateConstraint(_ layout: AutoLayout, _ mainAttr: NSLayoutConstraint.Attribute) {
        guard let relationBy = layout.relationBy else { return }
        
        let layoutConstraint = NSLayoutConstraint(item: layout.mainElement,
                                                  attribute: mainAttr,
                                                  relatedBy: relationBy,
                                                  toItem: setupToItem(layout),
                                                  attribute: layout.toAttribute ?? mainAttr,
                                                  multiplier: layout.multiplier,
                                                  constant: setupConstant(layout, mainAttr)
        )
        
        layoutConstraint.isActive = true
    }
    
    private func setupConstant(_ layout: AutoLayout, _ mainAttr: NSLayoutConstraint.Attribute) -> CGFloat {
        if (layout.mainAttribute.count > 1) {
            if mainAttr == .bottom || mainAttr == .trailing {
                let const = layout.constant
                return (const > 0) ? -const : 0.0
            }
        }
        return layout.constant
    }
    
    private func validateElementIsAdded(_ mainElement: UIView?) {
        guard let mainElement else {return}
        
        if mainElement.superview == nil {
            fatalError("Element \(mainElement) is not added!")
        }
    }
    
    private func setupToItem(_ layout: AutoLayout) -> Any? {
        if layout.typeElement == .safeArea {
            return toItemSafeArea(layout.mainElement)
        }
        if layout.typeElement == .superView {
            return toItemSuperView(layout.mainElement)
        }
        return layout.toItem
    }
    
    private func toItemSafeArea(_ mainElement: UIView) -> Any? {
        guard let safeArea = mainElement.superview?.safeAreaLayoutGuide else { return nil }
        return safeArea
    }
    
    private func toItemSuperView(_ mainElement: UIView) -> Any? {
        guard let superView = mainElement.superview else { return nil}
        return superView
    }

}
