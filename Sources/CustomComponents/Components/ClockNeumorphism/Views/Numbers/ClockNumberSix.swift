//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumberSix: ClockNumber  {
        
    override init(strokeModel: StrokeModel = StrokeModel()) {
        super.init(strokeModel: strokeModel)
        configure()
    }
    
    
    //  MARK: - LEFT
    lazy var leftTopStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()

    lazy var leftBottomStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()
    
    
    //  MARK: - MIDDLE
    lazy var middleMiddleStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()
    
    lazy var middleBottomStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()
    
    
    //  MARK: - RIGHT

    lazy var rightBottomStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()

    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        leftTopStroke.add(insideTo: clockNumberContainer.leftColumn.topView.get)
        leftBottomStroke.add(insideTo: clockNumberContainer.leftColumn.bottomView.get)
        middleMiddleStroke.add(insideTo: clockNumberContainer.middleColumn.middleView.get)
        middleBottomStroke.add(insideTo: clockNumberContainer.middleColumn.bottomView.get)
        rightBottomStroke.add(insideTo: clockNumberContainer.rightColumn.bottomView.get)
    }
    
    private func configConstraints() {
        leftTopStroke.applyConstraint()
        leftBottomStroke.applyConstraint()
        middleMiddleStroke.applyConstraint()
        middleBottomStroke.applyConstraint()
        rightBottomStroke.applyConstraint()
    }
    
    private func createStroke() -> Stroke {
        return Stroke(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
    }
    
}
