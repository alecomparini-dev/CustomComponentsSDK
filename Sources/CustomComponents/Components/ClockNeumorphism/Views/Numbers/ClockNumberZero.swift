//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumberZero: ClockNumber  {
        
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
    lazy var middleTopStroke: Stroke = {
        let comp = createStroke()
        return comp
    }()

    lazy var middleBottomStroke: Stroke = {
        let comp = createStroke()
            .setConstraints { build in
                build
                
            }
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
        leftBottomStroke.add(insideTo: clockNumberContainer.leftColumn.bottomView.get)
        
        middleTopStroke.add(insideTo: clockNumberContainer.leftColumn.topView.get)
        middleBottomStroke.add(insideTo: clockNumberContainer.leftColumn.bottomView.get)
        
        rightTopStroke.add(insideTo: clockNumberContainer.rightColumn.topView.get)
        rightBottomStroke.add(insideTo: clockNumberContainer.rightColumn.bottomView.get)
    }
    
    private func configConstraints() {
        leftTopStroke.applyConstraint()
        leftBottomStroke.applyConstraint()
        
        middleTopStroke.add(insideTo: clockNumberContainer.middleColumn.topView.get)
        middleBottomStroke.add(insideTo: clockNumberContainer.middleColumn.bottomView.get)
        
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
