        
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


public class ClockNeumorphismBuilderOld: ViewBuilder {
    
    enum Weight {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black
    }
    
    private var timer: DispatchSourceTimer?
    private var weight: CGFloat = 4
    private var enabledDay: Bool = false
    private var hour1: Int = 0
    private var hour2: Int = 0
    private var minute1: Int = 0
    private var minute2: Int = 0
    
    override public init() {
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addElements()
        configConstraints()
        startClock()
    }
    
    lazy var stackHours: StackViewBuilder = {
        let st = StackViewBuilder()
            .setDistribution(.fillEqually)
            .setAxis(.horizontal)
            .setSpacing(8)
        return st
    }()
    
    lazy var stackMinutes: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.horizontal)
            .setDistribution(.fillEqually)
            .setSpacing(8)
        return st
    }()
    
    lazy var day: LabelBuilder = {
        let label = LabelBuilder()
            .setSize(14)
            .setWeight(.thin)
            .setColor(Theme.shared.currentTheme.primary)
            .setTextAlignment(.right)
            .setConstraints { build in
                build
                    .setTop.equalTo(stackMinutes.get, .bottom, 5)
                    .setLeading.equalToSuperView(10)
                    .setTrailing.equalToSuperView(2)
            }
        return label
    }()
    
    lazy var twoPoints: ColonsView = {
        let comp = ColonsView()
        return comp
    }()
    
    
    
    //  MARK: - SET Properties
    @discardableResult
    public func setWeight(_ weight: CGFloat) -> Self {
        self.weight = weight
        return self
    }
    
    @discardableResult
    public func setEnabledDay(_ enabled: Bool) -> Self {
        self.enabledDay = enabled
        return self
    }
    
    
    //  MARK: - Private Function Area
    
    // TODO: - CREATE METHOD START OR SHOW AND UPDATE ONLY WHEN NUMBER CHANGES
    private func startClock() {
        updateClock()

        timer = DispatchSource.makeTimerSource()

        timer?.schedule(deadline: .now(), repeating: .seconds(1))

        timer?.setEventHandler { [weak self ] in

            DispatchQueue.main.async {
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "ss"
                
                if dateFormatter.string(from: Date()) == "00" {
                    self?.updateClock()
                }
                
            }
        }
        
        timer?.resume()
    }
    
    private func updateClock() {
        removeSubviews()
        ClockNumber1View().add(insideTo: stackHours.get)
        ClockNumber2View().add(insideTo: stackHours.get)
        ClockNumber5View().add(insideTo: stackMinutes.get)
        ClockNumber8View().add(insideTo: stackMinutes.get)
    }
    
    private func removeSubviews() {
        stackHours.get.subviews.forEach { $0.removeFromSuperview() }
        stackMinutes.get.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func getHour(firstPosition: Bool) -> Int {
        let hour = getDateFormatter("HH")
        if firstPosition {
            return Int(hour.prefix(1)) ?? 0
        }
        return Int(hour.prefix(2).suffix(1)) ?? 0
    }
    
    private func getMinute(firstPosition: Bool) -> Int {
        let minutes = getDateFormatter("mm")
        if firstPosition {
            return Int(minutes.prefix(1)) ?? 0
        }
        return Int(minutes.prefix(2).suffix(1)) ?? 0
    }
    
    private func getDateFormatter(_ formatter: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: Date())
    }
    
    
    private func addElements() {
        stackHours.add(insideTo: self.get)
        stackMinutes.add(insideTo: self.get)
        twoPoints.add(insideTo: self.get)
        day.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        configStackHoursConstraint()
        configTwoPointsConstraint()
        configStackMinutesConstraint()
        day.applyConstraint()
    }
    
    private func configStackHoursConstraint() {
        stackHours.setConstraints({ build in
            build
                .setPinLeft.equalToSuperView
                .setTrailing.equalTo(twoPoints.get, .leading, -3)
                .apply()
        })
            
    }
    
    private func configStackMinutesConstraint() {
        stackMinutes.setConstraints({ build in
            build
                .setPinRight.equalToSuperView
                .setLeading.equalTo(twoPoints.get, .trailing)
                .apply()
        })
    }
    
    private func configTwoPointsConstraint() {
        twoPoints.setConstraints({ build in
            build
                .setTop.setBottom.equalToSuperView
                .setWidth.equalToConstant(20)
                .setHorizontalAlignmentX.equalToSuperView
                .apply()
        })
    }
    
}