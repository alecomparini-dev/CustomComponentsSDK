//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class NumberColumnsView: ViewBuilder {

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
            .setSpacing(4)
            .setConstraints { build in
                build
                    .setPin.equalToSuperview
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
