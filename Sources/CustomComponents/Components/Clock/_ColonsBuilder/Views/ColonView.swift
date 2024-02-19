//  Created by Alessandro Comparini on 17/02/24.
//

import Foundation

class ColonView: ViewBuilder {
    
    private var neumorphism: NeumorphismBuilder!
    private let colonModel: ColonModel
    
    init(colonModel: ColonModel = ColonModel()) {
        self.colonModel = colonModel
        super.init()
        configure()
    }
    
    private func configure() {
        configNeumorphism()
        configShadow()
        applyNeumorphism()
    }
    
    private func configNeumorphism() {
        self.neumorphism = NeumorphismBuilder(self.get)
            .setReferenceColor(hexColor: colonModel.hexColor)
            .setShape(colonModel.shape)
            .setLightPosition(colonModel.lightPosition)
    }
    
    private func configShadow() {
        if !colonModel.isShadow { return }

        self.neumorphism
            .setShadowColor(to: .dark, color: .black)
            .setIntensity(to:.light,percent: 50)
            .setIntensity(to:.dark,percent: 100)
            .setBlur(to:.light, percent: 0)
            .setBlur(to:.dark, percent: 5)
            .setDistance(to:.light, percent: (colonModel.shadowDistance * 0.3))
            .setDistance(to:.dark, percent: colonModel.shadowDistance)
    }
    
    private func applyNeumorphism() {
        self.neumorphism.apply()
    }
    
}
