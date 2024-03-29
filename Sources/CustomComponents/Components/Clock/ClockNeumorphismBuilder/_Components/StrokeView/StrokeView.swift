//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation


class StrokeView: ViewBuilder {
    private let strokeModel: StrokeModel
    
    init(strokeModel: StrokeModel) {
        self.strokeModel = strokeModel
        super.init()
        configure()
    }
    
    private func configure() {
        configNeumorphism()
        configShadow()
    }
    
    private func configNeumorphism() {
        self.setNeumorphism({ build in
            build
                .setReferenceColor(hexColor: strokeModel.hexColor)
                .setShape(strokeModel.shape)
                .setLightPosition(strokeModel.lightPosition)
        })
            
    }
    
    private func configShadow() {
        if !strokeModel.isShadow { return }

        self.neumorphism?
            .setIntensity(to:.light,percent: 50)
            .setIntensity(to:.dark,percent: 100)
            .setBlur(to:.light, percent: 0)
            .setBlur(to:.dark, percent: 5)
            .setDistance(to:.light, percent: (strokeModel.shadowDistance * 0.3))
            .setDistance(to:.dark, percent: strokeModel.shadowDistance)
    }
    

}


