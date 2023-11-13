//  Created by Alessandro Comparini on 13/11/23.
//

import UIKit

open class NeumorphismBuilder: Neumorphism {
    
    private var lightShadowBuilder: ShadowBuilder?
    private var darkShadowBuilder: ShadowBuilder?
    
    private let darkShadowID: String = K.Neumorphism.Identifiers.darkShadowID.rawValue
    private let lightShadowID: String = K.Neumorphism.Identifiers.lightShadowID.rawValue
    private let shapeID: String = K.Neumorphism.Identifiers.shapeID.rawValue
    
    private let lightShadeColorPercentage: CGFloat = K.Neumorphism.Percentage.lightShadeColor.rawValue
    private let darkShadeColorPercentage: CGFloat = K.Neumorphism.Percentage.darkShadeColor.rawValue
    private let lightShapeColorByColorReferencePercentage: CGFloat = K.Neumorphism.Percentage.lightShapeColorByColorReference.rawValue
    private let darkShapeColorByColorReferencePercentage: CGFloat = K.Neumorphism.Percentage.darkShapeColorByColorReference.rawValue
    
    private var referenceColor: UIColor?
    private var lightShadowColor: UIColor?
    private var darkShadowColor: UIColor?
    private var darkShadowDistance: CGFloat = .zero
    private var lightShadowDistance: CGFloat = .zero
    private var lightShadowBlur: CGFloat = .zero
    private var darkShadowBlur: CGFloat = .zero
    private var lightShadowIntensity: Float = .zero
    private var darkShadowIntensity: Float = .zero
    private var shape: K.Neumorphism.Shape = .flat
    private var lightPosition: K.Neumorphism.LightPosition = .leftTop
    
    
    private weak var component: BaseBuilder?
    
    public init(_ component: BaseBuilder) {
        self.component = component
    }


//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setReferenceColor(color: UIColor?) -> Self {
        referenceColor = color
        return self
    }
    
    @discardableResult
    public func setReferenceColor(hexColor: String?) -> Self {
        guard let hexColor, hexColor.isHexColor() else {return self}
        setReferenceColor(color: UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setShadowColor(to shadow: K.Neumorphism.Shadow, color: UIColor) -> Self {
        switch shadow {
            case .light:
                lightShadowColor = color
            case .dark:
                darkShadowColor = color
        }
        return self
    }
    
    @discardableResult
    public func setShadowColor(to shadow: K.Neumorphism.Shadow, hexColor: String) -> Self {
        guard hexColor.isHexColor() else {return self}
        setShadowColor(to: shadow, color: UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setShadowColor(color: UIColor?) -> Self {
        lightShadowColor = color
        darkShadowColor = color
        return self
    }
    
    @discardableResult
    public func setShadowColor(hexColor: String?) -> Self {
        guard let hexColor, hexColor.isHexColor() else {return self}
        setShadowColor(color: UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setDistance(percent distance: CGFloat) -> Self {
        if !validatePercent(K.Neumorphism.Strings.distance, distance, 10) { return self}
        let distance = calculateRatioPercent(50, distance)
        lightShadowDistance = distance
        darkShadowDistance = distance
        return self
    }
    
    @discardableResult
    public func setDistance(to: K.Neumorphism.Shadow, percent distance: CGFloat) -> Self {
        if !validatePercent(K.Neumorphism.Strings.distance, distance, 10) { return self }
        let percentDistance = calculateRatioPercent(50, distance)
        switch to {
            case .light:
                lightShadowDistance = percentDistance
            case .dark:
                darkShadowDistance = percentDistance
        }
        return self
    }
    
    @discardableResult
    public func setBlur(percent blur: CGFloat) -> Self {
        if !validatePercent(K.Neumorphism.Strings.blur, blur, 10) { return self}
        let percentBlur = calculateRatioPercent(50, blur)
        lightShadowBlur = percentBlur
        darkShadowBlur = percentBlur
        return self
    }
    
    @discardableResult
    public func setBlur(to: K.Neumorphism.Shadow, percent blur: CGFloat) -> Self {
        if !validatePercent(K.Neumorphism.Strings.blur, blur, 10) { return self }
        let percentBlur = calculateRatioPercent(50, blur)
        switch to {
            case .light:
                lightShadowBlur = percentBlur
            case .dark:
                darkShadowBlur = percentBlur
        }
        return self
    }
    
    @discardableResult
    public func setIntensity(percent intensity: CGFloat) -> Self {
        if !validatePercent(K.Neumorphism.Strings.intensity, intensity, 100) { return self }
        let percentIntensity =  Float(calculateRatioPercent(100, intensity)) / 100
        darkShadowIntensity = percentIntensity
        lightShadowIntensity = percentIntensity
        return self
    }
    
    @discardableResult
    public func setIntensity(to: K.Neumorphism.Shadow, percent intensity: CGFloat) -> Self {
        if !validatePercent(K.Neumorphism.Strings.intensity, intensity, 100) { return self }
        let percentIntensity = Float(calculateRatioPercent(100, intensity)) / 100
        switch to {
            case .light:
                lightShadowIntensity = percentIntensity
            case .dark:
                darkShadowIntensity = percentIntensity
        }
        return self
    }
    
    @discardableResult
    public func setShape(_ shape: K.Neumorphism.Shape) -> Self {
        self.shape = shape
        return self
    }
    
    @discardableResult
    public func setLightPosition(_ lightPosition: K.Neumorphism.LightPosition) -> Self {
        self.lightPosition = lightPosition
        return self
    }

    
//  MARK: - APPLY NEUMORPHISM
    @discardableResult
    public func apply() -> Self {
        removeNeumorphism()
        calculateShadeColorByColorReference()
        applyShadow()
        applyShape()
        return self
    }
    
    
//  MARK: - REMOVE NEUMORPHIS
    public func removeNeumorphism() {
        component?.baseView.removeShadowByID(darkShadowID)
        component?.baseView.removeShadowByID(lightShadowID)
        component?.baseView.removeGradientByID(shapeID)
    }
    

//  MARK: - PRIVATE AREA
    private func applyShadow() {
        let (offSetDarkShadow, offSetLightShadow) = self.calculateLightPosition()
        self.applyDarkShadow(offSetDarkShadow)
        self.applyLightShadow(offSetLightShadow)
        
    }
    
    private func validatePercent(_ property: String , _ percent: CGFloat, _ defaultPercent: CGFloat ) -> Bool {
        if !Validates.percent(percent)  {
            debugPrint("Allowed values for \(property) 0.0...100.0%. Default \(defaultPercent)%")
            return false
        }
        return true
    }
    
    private func calculateRatioPercent(_ max: CGFloat, _ percent: CGFloat) -> CGFloat {
        return (percent * max) / 100
    }
    
    private func calculateLightPosition() -> (CGSize, CGSize) {
        let darkDistance = self.darkShadowDistance
        let lightDistance = self.lightShadowDistance
        
        switch self.lightPosition {
            case .leftTop:
                let darkOffset = CGSize(width: darkDistance, height: darkDistance)
                let lightOffset = CGSize(width: -lightDistance, height: -lightDistance)
                return (darkOffset, lightOffset)
            
            case .leftBottom:
                let darkOffset = CGSize(width: darkDistance, height: -darkDistance)
                let lightOffset = CGSize(width: -lightDistance, height: lightDistance)
                return (darkOffset, lightOffset)
            
            case .rightTop:
                let darkOffset = CGSize(width: -darkDistance, height: darkDistance)
                let lightOffset = CGSize(width: lightDistance, height: -lightDistance)
                return (darkOffset, lightOffset)
            
            case .rightBottom:
                let darkOffset = CGSize(width: -darkDistance, height: -darkDistance)
                let lightOffset = CGSize(width: lightDistance, height: lightDistance)
                return (darkOffset, lightOffset)
        }
    }
    
    
//  MARK: - SHADOW AREA
    
    private func applyDarkShadow(_ offSetDarkShadow: CGSize) {
        guard let component else {return}
        darkShadowBuilder = ShadowBuilder(component)
            .setColor(color: darkShadowColor ?? .clear)
            .setOffset(offSetDarkShadow)
            .setOpacity(darkShadowIntensity)
            .setRadius(darkShadowBlur)
            .setID(darkShadowID)
            .applyLayer()
        
    }
    
    private func applyLightShadow(_ offSetLightShadow: CGSize) {
        guard let component else {return}
        lightShadowBuilder = ShadowBuilder(component)
            .setColor(color: lightShadowColor ?? .clear)
            .setOffset(offSetLightShadow)
            .setOpacity(lightShadowIntensity)
            .setRadius(lightShadowBlur)
            .setID(lightShadowID)
            .applyLayer()
        
    }
    
    private func calculateShadeColorByColorReference() {
        calculateLightShade()
        calculateDarkShade()
    }
    
    private func calculateDarkShade() {
        if self.darkShadowColor != nil { return }
        guard let referenceColor = referenceColor else {return }
        self.setShadowColor(to: .dark, color: referenceColor.adjustBrightness(darkShadeColorPercentage))
    }

    private func calculateLightShade() {
        if self.lightShadowColor != nil { return }
        guard let referenceColor = referenceColor else {return }
        self.setShadowColor(to: .light, color: referenceColor.adjustBrightness(lightShadeColorPercentage))

    }


//  MARK: - SHAPE AREA
    
    private func applyShape() {
        switch self.shape {
            case .flat:
                setShapeFlat()
                return
            case .concave:
                setShapeConcave()
                return
            case .convex:
                setShapeConvex()
                return
            case .pressed:
                return
            case .none:
                return
        }
    }
    
    private func getShapeColorByColorReference() -> (UIColor,UIColor) {
        let dark = self.referenceColor!.adjustBrightness(darkShapeColorByColorReferencePercentage)
        let light = self.referenceColor!.adjustBrightness(lightShapeColorByColorReferencePercentage)
        return (dark,light)
    }
    
    private func addShapeOnComponent(_ color: [UIColor]) {
        guard let component else {return}
        _ = GradientBuilder(component.baseView)
            .setGradientColors(color)
            .setAxialGradient(self.calculateGradientDirection())
            .setID(shapeID)
            .apply()        
    }
    
    private func calculateGradientDirection() -> K.Gradient.Direction {
        switch lightPosition {
            case .leftTop:
                return .leftTopToRightBottom
            case .leftBottom:
                return .leftBottomToRightTop
            case .rightTop:
                return .rightTopToLeftBottom
            case .rightBottom:
                return .rightBottomToLeftTop
        }
    }
    
    private func setShapeConcave() {
        let (dark,light) = getShapeColorByColorReference()
        self.addShapeOnComponent([dark,light])
    }
    
    private func setShapeConvex() {
        let (dark,light) = getShapeColorByColorReference()
        self.addShapeOnComponent([light,dark])
    }
    
    private func setShapeFlat() {
        if let referenceColor {
            self.addShapeOnComponent([referenceColor, referenceColor])
        }
    }
    
}


