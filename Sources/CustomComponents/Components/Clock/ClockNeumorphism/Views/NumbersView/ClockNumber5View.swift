//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber5View: ClockNumberView  {
        
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
        leftTopStroke.add(insideTo: clockNumberContainer.leftColumn.topView.get)
        middleTopStroke.add(insideTo: clockNumberContainer.middleColumn.topView.get)
        middleMiddleStroke.add(insideTo: clockNumberContainer.middleColumn.middleView.get)
        middleBottomStroke.add(insideTo: clockNumberContainer.middleColumn.bottomView.get)
        rightBottomStroke.add(insideTo: clockNumberContainer.rightColumn.bottomView.get)
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
