//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber8View: ClockNumberView  {
    
    let strokeModel: StrokeModel
    
    init(strokeModel: StrokeModel = StrokeModel()) {
        self.strokeModel = strokeModel
        super.init()
        configure()
    }
    
    
    //  MARK: - LEFT
    lazy var leftTopStroke: StrokeView = {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(2)
                    .setBottom.equalToSuperView(-1)
                    .setLeading.setTrailing.equalToSuperView
            }
    }()

    lazy var leftBottomStroke: StrokeView = {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(1)
                    .setBottom.equalToSuperView(-2)
                    .setLeading.setTrailing.equalToSuperView
            }
    }()
    
    
    //  MARK: - MIDDLE
    lazy var middleTopStroke: StrokeView = {
        let comp = StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperView
                    .setLeading.equalToSuperView(-2)
                    .setTrailing.equalToSuperView(2)
            }
        return comp
    }()

    lazy var middleMiddleStroke: StrokeView = {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
    }()
    
    lazy var middleBottomStroke: StrokeView = {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperView
                    .setLeading.equalToSuperView(-2)
                    .setTrailing.equalToSuperView(2)
            }
    }()
    
    
    //  MARK: - RIGHT
    lazy var rightTopStroke: StrokeView = {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(2)
                    .setBottom.equalToSuperView(-1)
                    .setLeading.setTrailing.equalToSuperView
            }
    }()

    lazy var rightBottomStroke: StrokeView = {
        return StrokeView(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(1)
                    .setBottom.equalToSuperView(-2)
                    .setLeading.setTrailing.equalToSuperView
            }
    }()

    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        middleTopStroke.add(insideTo: middleColumn.topView.get)
        middleMiddleStroke.add(insideTo: middleColumn.middleView.get)
        middleBottomStroke.add(insideTo: middleColumn.bottomView.get)
        leftTopStroke.add(insideTo: leftColumn.topView.get)
        leftBottomStroke.add(insideTo: leftColumn.bottomView.get)
        rightTopStroke.add(insideTo: rightColumn.topView.get)
        rightBottomStroke.add(insideTo: rightColumn.bottomView.get)
    }
    
    private func configConstraints() {
        leftTopStroke.applyConstraint()
        leftBottomStroke.applyConstraint()
        middleTopStroke.applyConstraint()
        middleMiddleStroke.applyConstraint()
        middleBottomStroke.applyConstraint()
        rightTopStroke.applyConstraint()
        rightBottomStroke.applyConstraint()
    }
    
    
}
