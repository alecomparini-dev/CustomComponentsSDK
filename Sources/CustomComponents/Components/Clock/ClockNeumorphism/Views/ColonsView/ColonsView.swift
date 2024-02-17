//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

class ColonsView: ViewBuilder {
    
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA
    lazy var stackContainer: StackViewBuilder = {
        let st = StackViewBuilder()
            .setAxis(.vertical)
            .setAlignment(.fill)
            .setDistribution(.fillEqually)
            .setConstraints({ build in
                build
                    .setPin.equalToSuperView
            })
        return st
    }()
    
    
    

//  MARK: - PRIVATE AREA
    private func configure() {
        addElement()
        configConstraints()
    }
    
    private func addElement() {
        
    }
    
    private func configConstraints() {
        
    }
    
    
    
}
