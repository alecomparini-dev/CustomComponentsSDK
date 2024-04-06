//  Created by Alessandro Comparini on 06/04/24.
//

import UIKit

class DropdownMenuFooterView: ViewBuilder {
    
    private(set) var heightAnchorConst: NSLayoutConstraint!
    
    init(height: CGFloat) {
        heightAnchorConst.constant = height
        super.init()
        configure()     
//        self.setBackgroundColor(.purple)
    }
    
    
//  MARK: - PUBLIC AREA
    func applyLayout() {
        heightAnchorConst.isActive = true
        self.applyAutoLayout()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configConstraints()
    }
    
    private func configConstraints() {
        heightAnchorConst = self.get.heightAnchor.constraint(equalToConstant: 50)
        self
            .setAutoLayout { build in
                build
                    .pinBottom.equalToSuperview()
            }
    }
    
}

