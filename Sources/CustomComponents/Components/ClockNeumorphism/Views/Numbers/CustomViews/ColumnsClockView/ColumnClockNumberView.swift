//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ColumnClockNumberView: ViewBuilder {

    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA
    lazy var stackView: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setDistribution(.fillEqually)
            .setSpacing(4)
        return st
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
    }
    
    private func addElement() {
        stackView.add(insideTo: self.get)
    }

}


