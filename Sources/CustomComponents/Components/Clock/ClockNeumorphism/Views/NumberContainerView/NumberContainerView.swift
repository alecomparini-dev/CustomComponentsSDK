//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class NumberContainerView: ViewBuilder {
    
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
            .setSpacing(4)
            .setConstraints({ build in
                build
                    .setPin.equalToSuperView
            })
        return st
    }()
    
    lazy var leftColumn: OuterNumberColumnView = {
        let comp = OuterNumberColumnView()
        return comp
    }()
    
    lazy var middleColumn: MiddleNumberColumnView = {
        let comp = MiddleNumberColumnView()
        return comp
    }()
    
    lazy var rightColumn: OuterNumberColumnView = {
        let comp = OuterNumberColumnView()
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
    }
    
}
