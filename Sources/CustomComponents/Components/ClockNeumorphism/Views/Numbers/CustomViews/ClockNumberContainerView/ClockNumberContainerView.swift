//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumberContainer: ViewBuilder {
    
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA
    lazy var stackContainer: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setDistribution(.fillEqually)
            .setConstraints({ build in
                build
                    .setPin.equalToSuperView
            })
        return st
    }()
    
    lazy var leftColumn: OuterColumnClockNumberView = {
        let comp = OuterColumnClockNumberView()
        return comp
    }()
    
    lazy var middleColumn: MiddleColumnClockNumberView = {
        let comp = MiddleColumnClockNumberView()
        return comp
    }()
    
    lazy var rightColumn: OuterColumnClockNumberView = {
        let comp = OuterColumnClockNumberView()
        return comp
    }()
    

//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        stackContainer.add(insideTo: self.get)
        leftColumn.add(insideTo: stackContainer.get)
        middleColumn.add(insideTo: stackContainer.get)
        rightColumn.add(insideTo: stackContainer.get)
    }
    
    private func configConstraints() {
        stackContainer.applyConstraint()

        rightColumn.setBackgroundColor(.blue)
        rightColumn.topView.setBackgroundColor(.yellow)
        rightColumn.bottomView.setBackgroundColor(.red)
        
    }
    
}
