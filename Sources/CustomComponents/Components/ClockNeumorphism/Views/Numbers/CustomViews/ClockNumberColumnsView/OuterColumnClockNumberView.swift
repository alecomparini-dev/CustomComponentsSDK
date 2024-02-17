//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation


class OuterColumnClockNumberView: ColumnClockNumberView {
    
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA

    lazy var topView: ViewBuilder = {
        return ViewBuilder()
    }()
    
    lazy var bottomView: ViewBuilder = {
        return ViewBuilder()
    }()


//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
    }
    
    private func addElement() {
        topView.add(insideTo: stackView.get)
        bottomView.add(insideTo: stackView.get)
    }

}

