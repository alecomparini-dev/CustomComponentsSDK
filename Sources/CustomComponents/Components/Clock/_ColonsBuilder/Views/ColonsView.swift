//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

class ColonsView: ViewBuilder {
    
    private let colonModel: ColonModel
    
    init(colonModel: ColonModel = ColonModel()) {
        self.colonModel = colonModel
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA
    private lazy var stackContainer: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.vertical)
            .setAlignment(.center)
            .setDistribution(.fillEqually)
            .setConstraints({ build in
                build
                    .setPin.equalToSuperview
            })
        return st
    }()
    
    private lazy var colonBottomView: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    private lazy var colonTopView: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()

    private lazy var colonTop: ColonView = {
        let comp = createColonView()
        return comp
    }()

    private lazy var colonBottom: ColonView = {
        let comp = createColonView()
        return comp
    }()



//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        stackContainer.add(insideTo: self.get)
        colonTopView.add(insideTo: stackContainer.get)
        colonBottomView.add(insideTo: stackContainer.get)
        colonTop.add(insideTo: colonTopView.get)
        colonBottom.add(insideTo: colonBottomView.get)
    }
    
    private func configConstraints() {
        stackContainer.applyConstraint()
        colonBottomView.applyConstraint()
        colonTopView.applyConstraint()
        colonTop.applyConstraint()
        colonBottom.applyConstraint()
    }
    
    private func createColonView() -> ColonView {
        return ColonView(colonModel: colonModel)
            .setConstraints { build in
                build
                    .setSize.equalToConstant(colonModel.radius)
                    .setAlignmentCenterXY.equalToSuperview
            }
    }
    
    
}
