//  Created by Alessandro Comparini on 17/02/24.
//

import UIKit

public class ClockNeumorphismBuilder: BaseBuilder, ClockNeumorphism {

    private var strokeModel: StrokeModel!
    private var colonModel: ColonModel!
    
    struct Clock {
        static var hourLeft: ClockNumber!
        static var hourRight: ClockNumber!
        static var minLeft: ClockNumber!
        static var minRight: ClockNumber!
    }
    
    private let clockNeumorphism: ClockNeumorphismView
    private var hours: ViewBuilder?
    private var minutes: ViewBuilder?
    
    public init() {
        self.strokeModel = StrokeModel()
        self.colonModel = ColonModel()
        self.clockNeumorphism = ClockNeumorphismView()
        super.init(clockNeumorphism.get)
        configure()
    }

    
//  MARK: - PUBLIC AREA
    
    public var getClock: ViewBuilder {
        return clockNeumorphism
    }

    public var getHours: ViewBuilder {
        return hours ?? ViewBuilder()
    }

    public var getMinutes: ViewBuilder {
        return minutes ?? ViewBuilder()
    }
    
    
//  MARK: - SET PROPERTIES

    @discardableResult
    public func setShape(_ shape: K.Neumorphism.Shape) -> Self {
        strokeModel.shape = shape
        return self
    }

    @discardableResult
    public func setColor(hexColor: String) -> Self {
        if !hexColor.isHexColor() { return self }
        strokeModel.hexColor = hexColor
        return self
    }
    
    @discardableResult
    public func setDisableShadow() -> Self {
        strokeModel.isShadow = false
        return self
    }
    
    @discardableResult
    public func setShadowDistance(_ distance: CGFloat = 10) -> Self {
        strokeModel.shadowDistance = distance
        return self
    }
    
    @discardableResult
    public func setLightPosition(_ position: K.Neumorphism.LightPosition) -> Self {
        strokeModel.lightPosition = position
        return self
    }
    
    @discardableResult
    public func setColonsStyle(_ build: (_ build: ColonsStyleBuilder) -> ColonsStyleBuilder) -> Self {
        colonModel = build(ColonsStyleBuilder()).get
        return self
    }
    
//  MARK: - ACTIONS

    public func stopClock() {
        
    }
    

    
//  MARK: - PRIVATE AREA

    private func configure() {
        createBaseNumberView()
        addBaseNumberView()
        configConstraints()
        startClock()
    }
        
    private func createBaseNumberView() {
        Clock.hourLeft = ClockNumber(strokeModel: strokeModel)
        Clock.hourRight = ClockNumber(strokeModel: strokeModel)
        Clock.minLeft = ClockNumber(strokeModel: strokeModel)
        Clock.minRight = ClockNumber(strokeModel: strokeModel)
    }

    private func addBaseNumberView() {
        Clock.hourLeft.get.add(insideTo: clockNeumorphism.hoursContainerView.leftNumberView.get )
        Clock.hourRight.get.add(insideTo: clockNeumorphism.hoursContainerView.rightNumberView.get )
        Clock.minLeft.get.add(insideTo: clockNeumorphism.minutesContainerView.leftNumberView.get )
        Clock.minRight.get.add(insideTo: clockNeumorphism.minutesContainerView.rightNumberView.get )
    }
    
    private func configConstraints() {
        Clock.hourLeft.get.setConstraints { build in
            build
                .setPin.equalToSuperView
                .apply()
        }
        
        Clock.hourRight.get.setConstraints { build in
            build
                .setPin.equalToSuperView
                .apply()
        }
        
        Clock.minLeft.get.setConstraints { build in
            build
                .setPin.equalToSuperView
                .apply()
        }
        
        Clock.minRight.get.setConstraints { build in
            build
                .setPin.equalToSuperView
                .apply()
        }
    }
    
    private func startClock() {
        Clock.hourLeft.set(number: 0)
        Clock.hourRight.set(number: 1)
        Clock.minLeft.set(number: 8)
        Clock.minRight.set(number: 1)
    }

    
}



