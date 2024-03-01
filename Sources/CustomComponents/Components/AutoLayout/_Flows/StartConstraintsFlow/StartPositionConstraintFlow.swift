//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit


open class NSLayoutAnchor<AnchorType> {

    open func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
        return NSLayoutConstraint()
    }

    open func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
        return NSLayoutConstraint()
    }

    open func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
        return NSLayoutConstraint()
    }

    open func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>, constant c: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint()
    }

    open func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, constant c: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint()
    }

    open func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, constant c: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint()
    }
    
}


open class NSLayoutDimension : NSLayoutAnchor<NSLayoutDimension> {

    open func constraint(equalToConstant c: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint()
    }

    open func constraint(greaterThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint  {
        return NSLayoutConstraint()
    }

    open func constraint(lessThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint  {
        return NSLayoutConstraint()
    }

    
    open func constraint(equalTo anchor: NSLayoutDimension, multiplier m: CGFloat) -> NSLayoutConstraint  {
        return NSLayoutConstraint()
    }

    open func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat) -> NSLayoutConstraint  {
        return NSLayoutConstraint()
    }

    open func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat) -> NSLayoutConstraint  {
        return NSLayoutConstraint()
    }

    open func constraint(equalTo anchor: NSLayoutDimension, multiplier m: CGFloat, constant c: CGFloat) -> NSLayoutConstraint  {
        return NSLayoutConstraint()
    }

    open func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat, constant c: CGFloat) -> NSLayoutConstraint  {
        return NSLayoutConstraint()
    }

    open func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat, constant c: CGFloat) -> NSLayoutConstraint  {
        return NSLayoutConstraint()
    }
}
