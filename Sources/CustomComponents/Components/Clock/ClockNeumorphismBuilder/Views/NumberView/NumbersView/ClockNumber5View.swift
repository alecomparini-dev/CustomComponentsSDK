//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber5View: ClockNumberView  {
    
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

    
    //  MARK: - MIDDLE
    lazy var middleTopStroke: StrokeView = {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperView
                    .setLeading.equalToSuperView
                    .setTrailing.equalToSuperView
            }
    }()

    lazy var middleMiddleStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()
    
    lazy var middleBottomStroke: StrokeView = {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperView
                    .setLeading.equalToSuperView(-2)
                    .setTrailing.equalToSuperView
            }
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
        middleTopStroke.add(insideTo: middleColumn.topView.get)
        middleMiddleStroke.add(insideTo: middleColumn.middleView.get)
        middleBottomStroke.add(insideTo: middleColumn.bottomView.get)
        rightBottomStroke.add(insideTo: rightColumn.bottomView.get)
    }
    
    private func configConstraints() {
        leftTopStroke.applyConstraint()
        middleTopStroke.applyConstraint()
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
