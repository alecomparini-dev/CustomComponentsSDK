//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

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
            .setSpacing(40)
            .setConstraints({ build in
                build
                    .setPinLeft.equalToSuperView
                    .setTrailing.equalTo(colonsView.get, .leading)
            })
        return st
    }()

    lazy var colonsView: ColonsView = {
        let comp = ColonsView()
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperView
                    .setHorizontalAlignmentX.equalToSuperView
                    .setWidth.equalToConstant(8)
            }
        return comp
    }()

    lazy var minuteStackView: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.horizontal)
            .setDistribution(.fillEqually)
            .setSpacing(40)
            .setConstraints({ build in
                build
                    .setPinRight.equalToSuperView
                    .setLeading.equalTo(colonsView.get, .trailing)
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







