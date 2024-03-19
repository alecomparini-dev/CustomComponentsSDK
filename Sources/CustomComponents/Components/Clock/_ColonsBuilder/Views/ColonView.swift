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
    }
    
    private func configBorder() {
        self.setBorder({ build in
            build
                .setCornerRadius(colonModel.radius / 2)
        })
    }
    
    private func configNeumorphism() {
        self.neumorphism = NeumorphismBuilder(self.get)
                .setReferenceColor(hexColor: colonModel.hexColor)
                .setShadowColor(to: .dark, hexColor: colonModel.shadowHexColor)
                .setShape(colonModel.shape)
                .setLightPosition(colonModel.lightPosition)
                .setIntensity(to:.light,percent: 0)
                .setIntensity(to:.dark,percent: 100)
                .setBlur(to:.light, percent: 0)
                .setBlur(to:.dark, percent: 3)
                .setDistance(to:.light, percent: 3)
                .setDistance(to:.dark, percent: 10)
            
    }
    
    private func configShadow() {
        if !colonModel.isShadow { return }
    }
    

    
}
