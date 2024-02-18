//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber2View: ClockNumberView  {
    
    let strokeModel: StrokeModel
    
    init(strokeModel: StrokeModel = StrokeModel()) {
        self.strokeModel = strokeModel
        super.init()
        configure()
    }
    
    
    //  MARK: - LEFT
    lazy var leftBottomStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()
    
    
    //  MARK: - MIDDLE
    lazy var middleTopStroke: StrokeView = {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperView
                    .setLeading.equalToSuperView(-2)
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
                    .setLeading.equalToSuperView
                    .setTrailing.equalToSuperView(2)
            }
    }()
    
    
    //  MARK: - RIGHT
    lazy var rightTopStroke: StrokeView = {
        let comp = createStroke()
        return comp
    }()


    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        leftBottomStroke.add(insideTo: leftColumn.bottomView.get)
        middleTopStroke.add(insideTo: middleColumn.topView.get)
        middleMiddleStroke.add(insideTo: middleColumn.middleView.get)
        middleBottomStroke.add(insideTo: middleColumn.bottomView.get)
        rightTopStroke.add(insideTo: rightColumn.topView.get)
    }
    
    private func configConstraints() {
        leftBottomStroke.applyConstraint()
        middleTopStroke.applyConstraint()
        middleMiddleStroke.applyConstraint()
        middleBottomStroke.applyConstraint()
        rightTopStroke.applyConstraint()
    }
    
    private func createStroke() -> StrokeView {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
    }
    
}
