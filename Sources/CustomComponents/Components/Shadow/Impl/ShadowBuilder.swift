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
    
    private let _shadow: CAShapeLayer
    private weak var component: UIView?
    
    
//  MARK: - INITIALIZER
    
    public init(_ component: UIView) {
        self.component = component
        _shadow = CAShapeLayer()
        configure()
    }
    
    
//  MARK: - GET PROPERTIES
    
    public func getShadowById(_ id: String) -> CALayer? {
        return self.component?.layer.sublayers?.first(where: { $0.name == id })
    }
    
    public var shadow: CAShapeLayer { _shadow }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        _shadow.shadowColor = color.cgColor
        return self
    }
    
    @discardableResult
    public func setColor(hexColor: String?) -> Self {
        guard let hexColor, hexColor.isHexColor() else {return self}
        setColor( UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setOffset(width: Int, height: Int) -> Self {
        _shadow.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    public func setOffset(_ offSet: CGSize) -> Self {
        _shadow.shadowOffset = offSet
        return self
    }
    
    @discardableResult
    public func setOpacity(_ opacity: Float) -> Self {
        _shadow.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    public func setRadius(_ radius: CGFloat) -> Self {
        _shadow.shadowRadius = radius
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ cornerRadius: CGFloat) -> Self {
        _shadow.cornerRadius = cornerRadius
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
        _shadow.name = id
        return self
    }
    
    
//  MARK: - APPLY SHADOW
    
    
    public func apply() {
        component?.layer.shadowColor = _shadow.shadowColor ?? UIColor().cgColor
        component?.layer.shadowRadius = _shadow.shadowRadius
        component?.layer.shadowOpacity = _shadow.shadowOpacity
        component?.layer.shadowOffset = _shadow.shadowOffset
        
        applyFrame()
        applyComponentFrame()
        freeMemory()
        
    }
    
    public func applyLayer() {
        insertSubLayer()
        applyFrame()
        applyShadowFrame()
        freeMemory()
    }
    
    @discardableResult
    public func applyLayer(size: CGSize) -> Self {
        self._shadow.frame = CGRect(origin: .zero, size: size)
        let replicateCornerRadius = component?.layer.cornerRadius ?? 0
        self._shadow.shadowPath =  UIBezierPath(roundedRect: CGRect(origin: .zero, size: size),
                                                byRoundingCorners: component?.layer.maskedCorners.toRectCorner ?? .allCorners,
                                                cornerRadii: CGSize(width: replicateCornerRadius, height: replicateCornerRadius)).cgPath
        insertSubLayer()
        freeMemory()
        return self
    }
    
    private func freeMemory() {
        self.component = nil
    }
    
    
//  MARK: - PRIVATE AREA

    private func applyFrame() {
        self._shadow.frame = self.component?.bounds ?? .zero
    }
    
    private func applyComponentFrame() {
        self.component?.layer.shadowPath = self.calculateShadowPath()
    }
    
    private func applyShadowFrame() {
        self._shadow.shadowPath = self.calculateShadowPath()
    }
    
    private func getCornerRadius() -> CGFloat {
        guard let component else {return .zero}
        if let cornerRadius { return cornerRadius }
        return component.layer.cornerRadius
    }
    
    private func calculateShadowPath() -> CGPath {
        guard let component else { return CGPath(ellipseIn: .zero, transform: nil) }
        
        return component.replicateFormat(width: getShadowWidth(),
                                         height: getShadowHeight(),
                                         cornerRadius: getCornerRadius()
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
            shadowAt = UInt32(component.countShadows().shadowLayer)
        }
        component.layer.insertSublayer(_shadow, at: shadowAt)
    }
    
    private func configure() {
        setDefault()
        component?.layer.masksToBounds = false
        _shadow.shouldRasterize = true
        _shadow.rasterizationScale = UIScreen.main.scale
    }
    
    private func setDefault(){
        self
            .setColor(.black)
            .setOpacity(0.6)
            .setRadius(5)
    }
    
}

