//  Created by Alessandro Comparini on 26/02/24.
//

import UIKit

class StackViewToTopView: StackViewBuilder {
    
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        self
            .setAxis(.horizontal)
            .setSpacing(0)
            .setDistribution(.fill)
            .setConstraints { build in
                build
                    .setPin.equalToSuperview
            }
    }
    
    
}
