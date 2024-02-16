//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation


class ClockNumber: ViewBuilder {
    let strokeModel: StrokeModel
    
    init(strokeModel: StrokeModel = StrokeModel()) {
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



class ClockNumberOne: ClockNumber  {
        
    override init(strokeModel: StrokeModel) {
        super.init(strokeModel: strokeModel)
        configure()
    }
    
    lazy var rightTopStroke: Stroke = {
        let comp = Stroke(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView(2)
            }
        return comp
    }()

    lazy var rightBottomStroke: Stroke = {
        let comp = Stroke(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView(2)
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
