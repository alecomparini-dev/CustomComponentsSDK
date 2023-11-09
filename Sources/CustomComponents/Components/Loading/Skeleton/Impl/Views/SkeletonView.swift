//  Created by Alessandro Comparini on 09/11/23.
//

import UIKit


class SkeletonView: ViewBuilder {
    
    override init() {
        super.init()
    }
    
    lazy var skeletonLayer: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        configSkeleton()
    }
    
    private func configSkeleton() {
        self.get.layer.masksToBounds = true
    }
    
}

