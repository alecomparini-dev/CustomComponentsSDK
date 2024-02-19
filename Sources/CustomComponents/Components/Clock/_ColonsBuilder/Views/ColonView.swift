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
        configBorder()
        configNeumorphism()
        configShadow()
        applyNeumorphism()
    }
    
    private func configBorder() {
        self.setBorder({ build in
            build
                .setCornerRadius(colonModel.radius / 2)
        })
    }
    
    private func configNeumorphism() {
        self.setNeumorphism { build in
            build
                .setReferenceColor(hexColor: colonModel.hexColor)
                .setShape(.flat)
                .setLightPosition(.leftTop)
                .setShadowColor(to: .dark, color: .black)
                .setIntensity(to:.light,percent: 0)
                .setIntensity(to:.dark,percent: 100)
                .setBlur(to:.light, percent: 0)
                .setBlur(to:.dark, percent: 3)
                .setDistance(to:.light, percent: 3)
                .setDistance(to:.dark, percent: 10)
                .apply()
            
        }
//        self.neumorphism = NeumorphismBuilder(self.get)
            
    }
    
    private func configShadow() {
        if !colonModel.isShadow { return }

//        self.neumorphism
//            .setShadowColor(to: .dark, hexColor: colonModel.shadowHexColor)
//            .setIntensity(to:.light,percent: 50)
//            .setIntensity(to:.dark,percent: 100)
//            .setBlur(to:.light, percent: 0)
//            .setBlur(to:.dark, percent: 5)
//            .setDistance(to:.light, percent: (colonModel.shadowDistance * 0.3))
//            .setDistance(to:.dark, percent: colonModel.shadowDistance)
    }
    
    private func applyNeumorphism() {
//        self.neumorphism.apply()
    }
    
}
