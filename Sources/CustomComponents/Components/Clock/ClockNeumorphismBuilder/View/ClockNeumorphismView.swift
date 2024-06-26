//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

@MainActor
class ClockNeumorphismView: ViewBuilder {
    
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA
    lazy var hourStackView: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.horizontal)
            .setDistribution(.fillEqually)
            .setConstraints({ build in
                build
                    .setPinLeft.equalToSuperview
                    .setTrailing.equalTo(colonsView.get, .leading, -10)
            })
        return st
    }()

    lazy var colonsView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperview
                    .setHorizontalAlignmentX.equalToSuperview
                    .setWidth.equalToConstant(8)
            }
        return comp
    }()

    lazy var minuteStackView: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.horizontal)
            .setDistribution(.fillEqually)
            .setConstraints({ build in
                build
                    .setPinRight.equalToSuperview
                    .setLeading.equalTo(colonsView.get, .trailing, 8)
            })
        return st
    }()
    
    lazy var hoursContainerView: HoursOrMinutesContainerView = {
        let comp = HoursOrMinutesContainerView()
        return comp
    }()
    
    
    lazy var minutesContainerView: HoursOrMinutesContainerView = {
        let comp = HoursOrMinutesContainerView()
        return comp
    }()
    

//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        hourStackView.add(insideTo: self.get)
        colonsView.add(insideTo: self.get)
        minuteStackView.add(insideTo: self.get)
        hoursContainerView.add(insideTo: hourStackView.get)
        minutesContainerView.add(insideTo: minuteStackView.get)
    }
    
    private func configConstraints() {
        hourStackView.applyConstraint()
        colonsView.applyConstraint()
        minuteStackView.applyConstraint()
    }
    

}

