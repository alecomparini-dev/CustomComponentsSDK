//  Created by Alessandro Comparini on 17/02/24.
//

import UIKit

class ClockNeumorphismBuilder: ClockNeumorphism {
    
    private var strokeModel: StrokeModel!
    private var colonModel: ColonModel!
    
    private var clockNeumorphism: ViewBuilder?
    private var hours: ViewBuilder?
    private var minutes: ViewBuilder?
    
    init() {
        self.strokeModel = StrokeModel()
        self.colonModel = ColonModel()
        configure()
    }

    
//  MARK: - PUBLIC AREA
    
    public var getClock: ViewBuilder {
        return clockNeumorphism ?? ViewBuilder()
    }

    public var getHours: ViewBuilder {
        return hours ?? ViewBuilder()
    }

    public var getMinutes: ViewBuilder {
        return minutes ?? ViewBuilder()
    }
    
    
//  MARK: - SET PROPERTIES

    @discardableResult
    func setShape(_ shape: K.Neumorphism.Shape) -> Self {
        strokeModel.shape = shape
        return self
    }

    @discardableResult
    func setColor(hexColor: String) -> Self {
        if !hexColor.isHexColor() { return self }
        strokeModel.hexColor = hexColor
        return self
    }
    
    @discardableResult
    func setDisableShadow() -> Self {
        strokeModel.isShadow = false
        return self
    }
    
    @discardableResult
    func setShadowDistance(_ distance: CGFloat = 10) -> Self {
        strokeModel.shadowDistance = distance
        return self
    }
    
    @discardableResult
    func setLightPosition(_ position: K.Neumorphism.LightPosition) -> Self {
        strokeModel.lightPosition = position
        return self
    }
    
    @discardableResult
    func setColonsStyle(_ build: (_ build: ColonsStyleBuilder) -> ColonsStyleBuilder) -> Self {
        colonModel = build(ColonsStyleBuilder()).get
        return self
    }
    
    
    
//  MARK: - PRIVATE AREA

    private func configure() {
        startClock()
    }
    
    private func startClock() {
        
    }
    
}



