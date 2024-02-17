//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber: ViewBuilder {
    let strokeModel: StrokeModel
    
    init(strokeModel: StrokeModel) {
        self.strokeModel = strokeModel
        super.init()
        configure()
    }
    
    lazy var clockNumberContainer: ClockNumberContainer = {
        let comp = ClockNumberContainer()
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
