//  Created by Alessandro Comparini on 09/11/23.
//

import UIKit


class SkeletonView: ViewBuilder {
    
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        configSkeleton()
    }
    
    
    private func configSkeleton() {
        self.get.layer.masksToBounds = true
    }
    
}

