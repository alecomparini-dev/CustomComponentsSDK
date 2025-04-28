//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

@MainActor
class StrokeView: ViewBuilder {
    private let strokeModel: StrokeModel
    private var neumorphism: NeumorphismBuilder!
    
    init(strokeModel: StrokeModel) {
        self.strokeModel = strokeModel
        super.init()
        configure()
    }
    
    private func configure() {
        configNeumorphism()
        configShadow()
        applyNeumophism()
    }
    
    private func applyNeumophism() {
        neumorphism.apply()
    }
    
    private func configNeumorphism() {
        self.neumorphism = NeumorphismBuilder(self.get)
            .setReferenceColor(hexColor: strokeModel.hexColor)
            .setShape(strokeModel.shape)
            .setLightPosition(strokeModel.lightPosition)

    }
    
    private func configShadow() {
        if !strokeModel.isShadow { return }

        self.neumorphism
            .setIntensity(to:.light,percent: 50)
            .setIntensity(to:.dark,percent: 100)
            .setBlur(to:.light, percent: 0)
            .setBlur(to:.dark, percent: 5)
            .setDistance(to:.light, percent: (strokeModel.shadowDistance * 0.3))
            .setDistance(to:.dark, percent: strokeModel.shadowDistance)
    }
    

}


