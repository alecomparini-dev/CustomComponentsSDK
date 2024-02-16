//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation


class MiddleColumnClockNumberView: ColumnClockNumberView {
    
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA

    lazy private var top: ViewBuilder = {
        return ViewBuilder()
    }()

    lazy private var middle: ViewBuilder = {
        return ViewBuilder()
    }()

    lazy private var bottom: ViewBuilder = {
        return ViewBuilder()
    }()

    lazy var topView: ViewBuilder = {
        return ViewBuilder()
            .setConstraints { build in
                build
                    .setTop.equalToSuperView
                    .setLeading.setTrailing.equalToSuperView(-4)
                    .setHeight.equalToConstant(4)
            }
    }()

    lazy var middleView: ViewBuilder = {
        return ViewBuilder()
            .setConstraints { build in
                build
                    .setLeading.setTrailing.equalToSuperView(-4)
                    .setVerticalAlignmentY.equalToSuperView
                    .setHeight.equalToConstant(3)
            }
    }()

    lazy var bottomView: ViewBuilder = {
        return ViewBuilder()
            .setConstraints { build in
                build
                    .setBottom.equalToSuperView
                    .setLeading.setTrailing.equalToSuperView(-4)
                    .setHeight.equalToConstant(4)
            }
    }()

    
    

//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        top.add(insideTo: stackView.get)
        middle.add(insideTo: stackView.get)
        bottom.add(insideTo: stackView.get)
        
        topView.add(insideTo: top.get)
        middleView.add(insideTo: middle.get)
        bottomView.add(insideTo: bottom.get)
    }
    
    private func configConstraints() {
        topView.applyConstraint()
        middleView.applyConstraint()
        bottomView.applyConstraint()
    }
    

}

