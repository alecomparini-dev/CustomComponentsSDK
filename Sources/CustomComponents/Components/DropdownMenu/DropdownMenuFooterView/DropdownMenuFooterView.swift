//  Created by Alessandro Comparini on 06/04/24.
//

import UIKit

class DropdownMenuFooterView: ViewBuilder {
    
    private(set) var heightAnchorConst: NSLayoutConstraint!
    
    private let height: CGFloat
    
    init(height: CGFloat) {
        self.height = height
        super.init()
        configure()     
        self.setBackgroundColor(.white)
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
        heightAnchorConst = self.get.heightAnchor.constraint(equalToConstant: height)
        self
            .setAutoLayout { build in
                build
                    .pinBottom.equalToSuperview()
            }
    }
    
}

