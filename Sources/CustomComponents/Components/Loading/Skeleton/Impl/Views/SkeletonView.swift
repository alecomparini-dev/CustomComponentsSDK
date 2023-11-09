//  Created by Alessandro Comparini on 09/11/23.
//

import UIKit


class SkeletonView: ViewBuilder {
    
    override init() {
        super.init()
        configure()
    }
    
    lazy var skeletonLayer: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
        configSkeleton()
    }
    
    private func addElements() {
        skeletonLayer.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        skeletonLayer.applyConstraint()
    }
    
    private func configSkeleton() {
        self.get.layer.masksToBounds = true
    }
    
}

