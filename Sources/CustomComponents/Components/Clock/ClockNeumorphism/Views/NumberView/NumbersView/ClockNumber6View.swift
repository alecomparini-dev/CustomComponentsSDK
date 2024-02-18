//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber6View: NumberContainerView  {
    
    let strokeModel: StrokeModel
    
    init(strokeModel: StrokeModel = StrokeModel()) {
        self.strokeModel = strokeModel
        super.init()
        configure()
    }
    
    
    //  MARK: - LEFT
    lazy var leftTopStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()

    lazy var leftBottomStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()
    
    
    //  MARK: - MIDDLE
    lazy var middleMiddleStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()
    
    lazy var middleBottomStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()
    
    
    //  MARK: - RIGHT

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
        leftTopStroke.add(insideTo: leftColumn.topView.get)
        leftBottomStroke.add(insideTo: leftColumn.bottomView.get)
        middleMiddleStroke.add(insideTo: middleColumn.middleView.get)
        middleBottomStroke.add(insideTo: middleColumn.bottomView.get)
        rightBottomStroke.add(insideTo: rightColumn.bottomView.get)
    }
    
    private func configConstraints() {
        leftTopStroke.applyConstraint()
        leftBottomStroke.applyConstraint()
        middleMiddleStroke.applyConstraint()
        middleBottomStroke.applyConstraint()
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
