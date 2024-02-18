//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber0View: ClockNumberView  {
    
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
    lazy var middleTopStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()

    lazy var middleBottomStroke: StrokeView = {
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
        leftTopStroke.add(insideTo: leftColumn.topView.get)
        leftBottomStroke.add(insideTo: leftColumn.bottomView.get)
        middleTopStroke.add(insideTo: middleColumn.topView.get)
        middleBottomStroke.add(insideTo: middleColumn.bottomView.get)
        rightTopStroke.add(insideTo: rightColumn.topView.get)
        rightBottomStroke.add(insideTo: rightColumn.bottomView.get)
    }
    
    private func configConstraints() {
        leftTopStroke.applyConstraint()
        leftBottomStroke.applyConstraint()
        middleTopStroke.applyConstraint()
        middleBottomStroke.applyConstraint()
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
