//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumberOne: ClockNumber  {
        
    override init(strokeModel: StrokeModel = StrokeModel()) {
        super.init(strokeModel: strokeModel)
        configure()
    }
    
    lazy var rightTopStroke: Stroke = {
        let comp = Stroke(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()

    lazy var rightBottomStroke: Stroke = {
        let comp = Stroke(strokeModel: strokeModel)
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
        rightTopStroke.add(insideTo: clockNumberContainer.rightColumn.topView.get)
        rightBottomStroke.add(insideTo: clockNumberContainer.rightColumn.bottomView.get)
    }
    
    private func configConstraints() {
        rightTopStroke.applyConstraint()
        rightBottomStroke.applyConstraint()
    }
    
    
}
