//  Created by Alessandro Comparini on 08/11/23.
//

import UIKit

open class ShadowBuilder: Shadow {
    public typealias T = CALayer
    
    private var shadowAt: UInt32 = .zero
    private var isBringToFront: Bool = false
    private var cornerRadius: CGFloat?
    private var shadowHeight: CGFloat?
    private var shadowWidth: CGFloat?
    
    private let shadow: CAShapeLayer
    private(set) weak var component: UIView?
    
    
//  MARK: - INITIALIZER
    
    public init(_ component: UIView) {
        self.component = component
        shadow = CAShapeLayer()
        configure()
    }
    
    
//  MARK: - GET PROPERTIES
    
    public func getShadowById(_ id: String) -> CALayer? {
        return self.component?.layer.sublayers?.first(where: { $0.name == id })
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setColor(color: UIColor?) -> Self {
        guard let color else {return self}
        shadow.shadowColor = color.cgColor
        return self
    }
    
    @discardableResult
    public func setColor(hexColor: String?) -> Self {
        guard let hexColor, hexColor.isHexColor() else {return self}
        setColor(color: UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setOffset(width: Int, height: Int) -> Self {
        shadow.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    public func setOffset(_ offSet: CGSize) -> Self {
        shadow.shadowOffset = offSet
        return self
    }
    
    @discardableResult
    public func setOpacity(_ opacity: Float) -> Self {
        shadow.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    public func setRadius(_ radius: CGFloat) -> Self {
        shadow.shadowRadius = radius
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ cornerRadius: CGFloat) -> Self {
        shadow.cornerRadius = cornerRadius
        return self
    }
    
    @discardableResult
    public func setBringToFront() -> Self {
        self.isBringToFront = true
        return self
    }
    
    @discardableResult
    public func setShadowHeight(_ height: CGFloat) -> Self {
        self.shadowHeight = height
        return self
    }
    
    @discardableResult
    public func setShadowWidth(_ width: CGFloat) -> Self {
        self.shadowWidth = width
        return self
    }
    
    @discardableResult
    public func setID(_ id: String) -> Self {
        shadow.name = id
        return self
    }
    
    
//  MARK: - APPLY SHADOW
    
    @discardableResult
    public func apply() -> Self {
        component?.layer.shadowColor = shadow.shadowColor
        component?.layer.shadowRadius = shadow.shadowRadius
        component?.layer.shadowOpacity = shadow.opacity
        component?.layer.shadowOffset = shadow.shadowOffset
        DispatchQueue.main.async { [weak self] in
            guard let self, let component else {return}
            shadow.frame = component.bounds
            component.layer.shadowPath = calculateShadowPath()
        }
        return self
    }

    @discardableResult
    public func applyLayer() -> Self {
        self.insertSubLayer()
        DispatchQueue.main.async { [weak self] in
            guard let self, let component else {return}
            shadow.frame = component.bounds
            shadow.shadowPath = calculateShadowPath()
        }
        return self
    }

    
//  MARK: - PRIVATE AREA
    
    private func getCornerRadius() -> CGFloat {
        guard let component else {return .zero}
        if let cornerRadius { return cornerRadius }
        return component.layer.cornerRadius
    }
    
    private func calculateShadowPath() -> CGPath {
        return component!.replicateFormat(width: self.getShadowWidth(),
                                         height: self.getShadowHeight(),
                                         cornerRadius: self.getCornerRadius()
                                        ).cgPath
    }
    
    private func getShadowHeight() -> CGFloat {
        guard let component else {return .zero}
        if let shadowHeight { return shadowHeight }
        return component.frame.height
    }
    
    private func getShadowWidth() -> CGFloat {
        guard let component else {return .zero}
        if let shadowWidth { return shadowWidth }
        return component.frame.width
    }
    
    private func insertSubLayer() {
        guard let component else {return }
        if isBringToFront {
            shadowAt = UInt32(component.countShadows())
        }
        component.layer.insertSublayer(shadow, at: shadowAt)
    }
    
    private func configure() {
        setDefault()
        component?.layer.masksToBounds = false
        shadow.shouldRasterize = true
        shadow.rasterizationScale = UIScreen.main.scale
    }
    
    private func setDefault(){
        self
            .setOpacity(0.6)
            .setRadius(5)
    }
    
}

