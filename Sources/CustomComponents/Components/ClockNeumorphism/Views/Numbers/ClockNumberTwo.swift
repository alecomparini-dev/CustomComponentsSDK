//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumberTwo: ClockNumber  {
        
    override init(strokeModel: StrokeModel = StrokeModel()) {
        super.init(strokeModel: strokeModel)
        configure()
    }
    
    
    //  MARK: - LEFT
    lazy var leftBottomStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()
    
    
    //  MARK: - MIDDLE
    lazy var middleTopStroke: Stroke = {
        return Stroke(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperView
                    .setLeading.equalToSuperView(-2)
                    .setTrailing.equalToSuperView
            }
    }()

    lazy var middleMiddleStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()
    
    lazy var middleBottomStroke: Stroke = {
        return Stroke(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperView
                    .setLeading.equalToSuperView
                    .setTrailing.equalToSuperView(2)
            }
    }()
    
    
    //  MARK: - RIGHT
    lazy var rightTopStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()


    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        leftBottomStroke.add(insideTo: clockNumberContainer.leftColumn.bottomView.get)
        middleTopStroke.add(insideTo: clockNumberContainer.middleColumn.topView.get)
        middleMiddleStroke.add(insideTo: clockNumberContainer.middleColumn.middleView.get)
        middleBottomStroke.add(insideTo: clockNumberContainer.middleColumn.bottomView.get)
        rightTopStroke.add(insideTo: clockNumberContainer.rightColumn.topView.get)
    }
    
    private func configConstraints() {
        leftBottomStroke.applyConstraint()
        middleTopStroke.applyConstraint()
        middleMiddleStroke.applyConstraint()
        middleBottomStroke.applyConstraint()
        rightTopStroke.applyConstraint()
    }
    
    private func createStroke() -> Stroke {
        return Stroke(strokeModel: strokeModel)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
    }
    
}
