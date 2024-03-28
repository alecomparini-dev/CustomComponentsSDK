//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation


class MiddleNumberColumnView: NumberColumnsView {
    
    private let constant: CGFloat = 4
    
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA

    private lazy var top: ViewBuilder = {
        return ViewBuilder()
    }()

    private lazy var middle: ViewBuilder = {
        return ViewBuilder()
    }()

    private lazy var bottom: ViewBuilder = {
        return ViewBuilder()
    }()

    lazy var topView: ViewBuilder = {
        return ViewBuilder()
            .setConstraints { build in
                build
                    .setTop.equalToSuperview(-1)
                    .setLeading.equalToSuperview(-constant)
                    .setTrailing.equalToSuperview(constant)
                    .setHeight.equalToConstant(3)
            }
    }()

    lazy var middleView: ViewBuilder = {
        return ViewBuilder()
            .setConstraints { build in
                build
                    .setLeading.equalToSuperview(-constant)
                    .setTrailing.equalToSuperview(constant)
                    .setVerticalAlignmentY.equalToSuperview
                    .setHeight.equalToConstant(2)
            }
    }()

    lazy var bottomView: ViewBuilder = {
        return ViewBuilder()
            .setConstraints { build in
                build
                    .setBottom.equalToSuperview(1)
                    .setLeading.equalToSuperview(-constant)
                    .setTrailing.equalToSuperview(constant)
                    .setHeight.equalToConstant(3)
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

