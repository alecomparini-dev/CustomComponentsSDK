//  Created by Alessandro Comparini on 17/02/24.
//

import UIKit

public class ClockNeumorphismBuilder: BaseBuilder, ClockNeumorphism {
    private var alreadyApplied = false
    
    private var strokeModel: StrokeModel!
    private var colonModel: ColonModel!
    
    struct Clock {
        static var hourLeft: ClockNumber!
        static var hourRight: ClockNumber!
        static var minLeft: ClockNumber!
        static var minRight: ClockNumber!
    }
    private var colonsView: ColonsView!
    
    private var timer: Timer?
    
    private let clockNeumorphism: ClockNeumorphismView
    private var hours: ViewBuilder?
    private var minutes: ViewBuilder?
    
    public init() {
        self.strokeModel = StrokeModel()
        self.colonModel = ColonModel()
        self.clockNeumorphism = ClockNeumorphismView()
        super.init(clockNeumorphism.get)
    }
    
    
    deinit {
        timer?.invalidate()
        timer = nil
    }

    
//  MARK: - PUBLIC AREA
    
    public var getClock: ViewBuilder {
        return clockNeumorphism
    }

    public var getHours: ViewBuilder {
        return clockNeumorphism.hoursContainerView
    }

    public var getMinutes: ViewBuilder {
        return clockNeumorphism.minutesContainerView
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

    public func startClock() {
        applyOnceConfig()
    }
    
    public func hiddeClock() {
        timer?.invalidate()
        timer = nil
    }
    

    
//  MARK: - PRIVATE AREA

    private func applyOnceConfig() {
        if alreadyApplied { return }
        createBaseNumberView()
        createColonsView()
        addBaseNumberView()
        configConstraints()
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            configStyles()
        }
        startTime()
        alreadyApplied = true
    }
    
    private func createBaseNumberView() {
        Clock.hourLeft = ClockNumber(strokeModel: strokeModel)
        Clock.hourRight = ClockNumber(strokeModel: strokeModel)
        Clock.minLeft = ClockNumber(strokeModel: strokeModel)
        Clock.minRight = ClockNumber(strokeModel: strokeModel)
    }
    
    private func configStyles() {
        applyNeumorphismHourLeft()
        applyNeumorphismHourRight()
        applyNeumorphismMinLeft()
        applyNeumorphismMinRight()
        applyNeumorphismColon()
    }

    private func applyNeumorphismHourLeft() {
        Clock.hourLeft.get.leftTopStroke.applyNeumorphism()
        Clock.hourLeft.get.leftBottomStroke.applyNeumorphism()
        Clock.hourLeft.get.rightTopStroke.applyNeumorphism()
        Clock.hourLeft.get.rightBottomStroke.applyNeumorphism()
        Clock.hourLeft.get.middleTopStroke.applyNeumorphism()
        Clock.hourLeft.get.middleMiddleStroke.applyNeumorphism()
        Clock.hourLeft.get.middleBottomStroke.applyNeumorphism()
    }
    
    private func applyNeumorphismHourRight() {
        Clock.hourRight.get.leftTopStroke.applyNeumorphism()
        Clock.hourRight.get.leftBottomStroke.applyNeumorphism()
        Clock.hourRight.get.rightTopStroke.applyNeumorphism()
        Clock.hourRight.get.rightBottomStroke.applyNeumorphism()
        Clock.hourRight.get.middleTopStroke.applyNeumorphism()
        Clock.hourRight.get.middleMiddleStroke.applyNeumorphism()
        Clock.hourRight.get.middleBottomStroke.applyNeumorphism()
    }
    
    private func applyNeumorphismMinLeft() {
        Clock.minLeft.get.leftTopStroke.applyNeumorphism()
        Clock.minLeft.get.leftBottomStroke.applyNeumorphism()
        Clock.minLeft.get.rightTopStroke.applyNeumorphism()
        Clock.minLeft.get.rightBottomStroke.applyNeumorphism()
        Clock.minLeft.get.middleTopStroke.applyNeumorphism()
        Clock.minLeft.get.middleMiddleStroke.applyNeumorphism()
        Clock.minLeft.get.middleBottomStroke.applyNeumorphism()
    }
    
    private func applyNeumorphismMinRight() {
        Clock.minRight.get.leftTopStroke.applyNeumorphism()
        Clock.minRight.get.leftBottomStroke.applyNeumorphism()
        Clock.minRight.get.rightTopStroke.applyNeumorphism()
        Clock.minRight.get.rightBottomStroke.applyNeumorphism()
        Clock.minRight.get.middleTopStroke.applyNeumorphism()
        Clock.minRight.get.middleMiddleStroke.applyNeumorphism()
        Clock.minRight.get.middleBottomStroke.applyNeumorphism()
    }
    
    private func applyNeumorphismColon() {
        colonsView.colonTop.applyNeumorphism()
        colonsView.colonBottom.applyNeumorphism()
    }
    

    private func addBaseNumberView() {
        Clock.hourLeft.get.add(insideTo: clockNeumorphism.hoursContainerView.leftNumberView.get )
        Clock.hourRight.get.add(insideTo: clockNeumorphism.hoursContainerView.rightNumberView.get )
        Clock.minLeft.get.add(insideTo: clockNeumorphism.minutesContainerView.leftNumberView.get )
        Clock.minRight.get.add(insideTo: clockNeumorphism.minutesContainerView.rightNumberView.get )
    }
    
    private func createColonsView() {
        colonsView = ColonsView(colonModel: colonModel)
            .setConstraints { build in
                build
                    .setPin.equalToSuperview
            }
        colonsView.add(insideTo: clockNeumorphism.colonsView.get)
        colonsView.applyConstraint()
    }
    
    private func configConstraints() {
        Clock.hourLeft.get.setConstraints { build in
            build
                .setPin.equalToSuperview
                .apply()
        }
        
        Clock.hourRight.get.setConstraints { build in
            build
                .setPin.equalToSuperview
                .apply()
        }
        
        Clock.minLeft.get.setConstraints { build in
            build
                .setPin.equalToSuperview
                .apply()
        }
        
        Clock.minRight.get.setConstraints { build in
            build
                .setPin.equalToSuperview
                .apply()
        }
    }
    
    private func startTime() {
        let hours = getHour()
        updateClock(hours.currentHour, hours.currentMinute)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    @objc 
    private func updateTime() {
        let hours = getHour()
        
        if hours.currentSecond == "00" {
            updateClock(hours.currentHour, hours.currentMinute)
        }
    }
    
    private func getHour() -> (currentHour: String,currentMinute: String, currentSecond: String) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH"
        let currentHour = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "mm"
        let currentMinute = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "ss"
        let currentSecond = dateFormatter.string(from: Date())

        return (currentHour, currentMinute, currentSecond)
    }
    
    private func updateClock(_ currentHour: String, _ currentMinute: String) {
        let hourLeft = Int(currentHour.prefix(1)) ?? 0
        let hourRight = Int(currentHour.suffix(1)) ?? 0
        let minLeft = Int(currentMinute.prefix(1)) ?? 0
        let minRight = Int(currentMinute.suffix(1)) ?? 0
        
        Clock.hourLeft.set(number: hourLeft)
        Clock.hourRight.set(number: hourRight)
        Clock.minLeft.set(number: minLeft)
        Clock.minRight.set(number: minRight)
    }
    
    
}
