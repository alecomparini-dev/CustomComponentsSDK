//  Created by Alessandro Comparini on 09/11/23.
//

import UIKit

open class GradientBuilder: Gradient {
    public typealias T = CAGradientLayer
    public var get: CAGradientLayer? {self.gradient}
    
    private var size: CGSize?
    
    private var isAxial = false
    private let gradient: CAGradientLayer
    private let gradientID = K.Gradient.Identifiers.gradientID.rawValue
    
    private weak var component: UIView?
    
    
//  MARK: - INITIALIZERS
    
    public init(_ component: UIView) {
        self.component = component
        self.gradient = CAGradientLayer()
        configure()
    }
    
    public convenience init() {
        self.init(UIView())
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setGradientColors(_ colors: [UIColor]) -> Self {
        gradient.colors = colors.map { $0.cgColor }
        return self
    }
    
    @discardableResult
    public func setGradientColors(hexColors: [String]) -> Self {
        setGradientColors( hexColors.map( {UIColor.HEX($0)} ) )
        return self
    }
    
    @discardableResult
    public func setReferenceColor(_ referenceColor: UIColor, percentageGradient: CGFloat) -> Self {
        let colors = [referenceColor, referenceColor.adjustBrightness(percentageGradient)]
        setGradientColors(colors)
        return self
    }
    
    @discardableResult
    public func setReferenceColor(referenceHexColor: String, percentageGradient: CGFloat) -> Self {
        setReferenceColor(UIColor.HEX(referenceHexColor), percentageGradient: percentageGradient)
        return self
    }
    
    @discardableResult
    public func setAxialGradient(_ direction: K.Gradient.Direction) -> Self {
        setGradientDirection(direction)
        setType(.axial)
        isAxial = true
        return self
    }
    
    @discardableResult
    public func setConicGradient(_ startPoint: CGPoint) -> Self {
        setStartPoint(startPoint.x, startPoint.y)
        setType(.conic)
        return self
    }
    
    @discardableResult
    public func setRadialGradient(startPoint: CGPoint, _ endPoint: CGPoint? = nil) -> Self {
        setStartPoint(startPoint.x, startPoint.y)
        gradient.endPoint = endPoint ?? CGPointZero
        setType(.radial)
        return self
    }
    
    @discardableResult
    public func setOpacity(_ opacity: Float) -> Self {
        gradient.opacity = opacity
        return self
    }
    
    @discardableResult
    public func setID(_ id: String) -> Self {
        gradient.name = id
        return self
    }
    
    
//  MARK: - APPLY GRADIENT
    @discardableResult
    public func apply() -> Self {
        removeGradient()
        applyMainThread()
        freeMemory()
        return self
    }
    
    public func apply(size: CGSize) -> Self {
        self.size = size
        removeGradient()
        applyMainThread()
        freeMemory()
        return self
    }
    
    private func freeMemory() {
        DispatchQueue.main.async {
            self.component = nil
            self.size = nil
        }
    }
    
//  MARK: - REMOVE GRADIENT
    public func removeGradient() {
        if let gradientName = gradient.name {
            component?.removeGradientByID(gradientName)
        }
    }

    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        configInitial()
        setGradientDirection(K.Gradient.Direction.leftToRight)
        setType(.axial)
        setID(gradientID)
    }
    
    private func configInitial() {
        gradient.shouldRasterize = true
        gradient.rasterizationScale = UIScreen.main.scale
        gradient.backgroundColor = .none
    }

    private func setGradientDirection(_ direction: K.Gradient.Direction) {
        switch direction {
            case .leftToRight:
                setStartPoint(0.0, 0.5)
                setEndPoint(1.0, 0.5)
            
            case .rightToLeft:
                setStartPoint(1.0, 0.5)
                setEndPoint(0.0, 0.5)
            
            case .topToBottom:
                setStartPoint(0.5, 0.0)
                setEndPoint(0.5, 1.0)
            
            case .bottomToTop:
                setStartPoint(0.5, 1.0)
                setEndPoint(0.5, 0.0)
            
            case .leftBottomToRightTop:
                setStartPoint(0.0, 1.0)
                setEndPoint(1.0, 0.0)
            
            case .leftTopToRightBottom:
                setStartPoint(0.0, 0.0)
                setEndPoint(1.0, 1.0)
            
            case .rightBottomToLeftTop:
                setStartPoint(1.0, 1.0)
                setEndPoint(0.0, 0.0)
            
            case .rightTopToLeftBottom:
                setStartPoint(1.0, 0.0)
                setEndPoint(0.0, 1.0)
        }
        
    }

    private func calculateIndexLayer() -> UInt32 {
        return UInt32(component?.countShadows().shadowLayer ?? 0)
    }
    
    private func setType(_ type: CAGradientLayerType) {
        gradient.type = type
    }
    
    private func setStartPoint(_ x: Double, _ y: Double) {
        gradient.startPoint = CGPoint(x: x, y: y)
    }
    
    private func setEndPoint(_ x: Double, _ y: Double) {
        gradient.endPoint = CGPoint(x: x, y: y)
    }
    
    
//  MARK: - APPLY

    private func applyMainThread() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            setGradientOnComponent()
            setFrame()
            calculateEndPoint()
        }
    }
    
    private func setGradientOnComponent() {
        let indexLayer = calculateIndexLayer()
        component?.layer.insertSublayer(gradient, at: indexLayer)
    }

    private func setFrame() {
        guard let component else { return }
        gradient.frame = component.bounds
        if let size {
            gradient.frame = CGRect(origin: .zero, size: size)
        }
        gradient.cornerRadius = component.layer.cornerRadius
        gradient.maskedCorners = component.layer.maskedCorners
    }
    
    private func calculateEndPoint() {
        guard let component else { return }
        
        if !isAxial && gradient.endPoint == CGPointZero {
            let endY = component.frame.size.width / component.frame.size.height / 2
            gradient.endPoint = CGPoint(x: 0, y: endY)
        }
    }
    
}
