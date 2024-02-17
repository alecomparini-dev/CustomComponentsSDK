//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber4View: ClockNumber  {
        
    override init(strokeModel: StrokeModel = StrokeModel()) {
        super.init(strokeModel: strokeModel)
        configure()
    }
    
    
    //  MARK: - LEFT
    lazy var leftTopStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()
    
    
    //  MARK: - MIDDLE
    lazy var middleMiddleStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()
    
    
    //  MARK: - RIGHT
    lazy var rightTopStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()

    lazy var rightBottomStroke: StrokeView = {
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
    
    private func createStroke() -> StrokeView {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
    }
    
}
