//  Created by Alessandro Comparini on 18/02/24.
//

import Foundation

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
