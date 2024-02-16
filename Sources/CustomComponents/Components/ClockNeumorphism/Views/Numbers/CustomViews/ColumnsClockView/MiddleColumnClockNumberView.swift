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
                    .setPinTop.equalToSuperView
                    .setHeight.equalToConstant(4)
            }
    }()

    lazy var middleView: ViewBuilder = {
        return ViewBuilder()
            .setConstraints { build in
                build
                    .setLeading.setTrailing.equalToSuperView
                    .setVerticalAlignmentY.equalToSuperView
                    .setHeight.equalToConstant(3)
            }
    }()

    lazy var bottomView: ViewBuilder = {
        return ViewBuilder()
            .setConstraints { build in
                build
                    .setPinBottom.equalToSuperView
                    .setHeight.equalToConstant(4)
            }
    }()

    
    

//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
    }
    
    private func addElement() {
        topView.add(insideTo: stackView.get)
        middleView.add(insideTo: stackView.get)
        bottomView.add(insideTo: stackView.get)
    }
    

}

