//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

class ClockNeumorphismView: ViewBuilder {
    
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA
    lazy var clockStackView: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setDistribution(.fillEqually)
            .setSpacing(4)
            .setConstraints({ build in
                build
                    .setPin.equalToSuperView
            })
        return st
    }()
    
    lazy var hoursContainerView: HoursOrMinutesContainerView = {
        let comp = HoursOrMinutesContainerView()
        return comp
    }()
    
    lazy var colonsView: ColonsView = {
        let comp = ColonsView()
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
        clockStackView.add(insideTo: self.get)
        hoursContainerView.add(insideTo: clockStackView.get)
        hoursContainerView.add(insideTo: clockStackView.get)
        minutesContainerView.add(insideTo: clockStackView.get)
    }
    
    private func configConstraints() {
        clockStackView.applyConstraint()
    }
    

}





class HoursOrMinutesContainerView: ViewBuilder {
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA
    lazy var stackView: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setDistribution(.fillEqually)
            .setSpacing(4)
            .setConstraints({ build in
                build
                    .setPin.equalToSuperView
            })
        return st
    }()
    
    lazy var leftNumberView: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    lazy var rightNumberView: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    

//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        stackView.add(insideTo: self.get)
        leftNumberView.add(insideTo: stackView.get)
        rightNumberView.add(insideTo: stackView.get)
    }
    
    private func configConstraints() {
        stackView.applyConstraint()
    }
        
}

