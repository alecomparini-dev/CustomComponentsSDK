//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ColumnClockNumberView: ViewBuilder {

    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA
    lazy var stackView: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.vertical)
            .setAlignment(.fill)
            .setDistribution(.fillEqually)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return st
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        stackView.add(insideTo: self.get)
    }

    private func configConstraints() {
        stackView.applyConstraint()
    }

}
