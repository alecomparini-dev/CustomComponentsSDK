//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumberFour: ClockNumber  {
        
    override init(strokeModel: StrokeModel = StrokeModel()) {
        super.init(strokeModel: strokeModel)
        configure()
    }
    
    
    //  MARK: - LEFT
    lazy var leftTopStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()
    
    
    //  MARK: - MIDDLE
    lazy var middleMiddleStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()
    
    
    //  MARK: - RIGHT
    lazy var rightTopStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()

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
        middleMiddleStroke.add(insideTo: clockNumberContainer.middleColumn.middleView.get)
        rightTopStroke.add(insideTo: clockNumberContainer.rightColumn.topView.get)
        rightBottomStroke.add(insideTo: clockNumberContainer.rightColumn.bottomView.get)
    }
    
    private func configConstraints() {
        leftTopStroke.applyConstraint()
        middleMiddleStroke.applyConstraint()
        rightTopStroke.applyConstraint()
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