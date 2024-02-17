//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumberView: ViewBuilder {
    let strokeModel: StrokeModel
    
    init(strokeModel: StrokeModel) {
        self.strokeModel = strokeModel
        super.init()
        configure()
    }
    
    lazy var clockNumberContainer: NumberContainerView = {
        let comp = NumberContainerView()
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        clockNumberContainer.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        clockNumberContainer.applyConstraint()
    }
    
}
