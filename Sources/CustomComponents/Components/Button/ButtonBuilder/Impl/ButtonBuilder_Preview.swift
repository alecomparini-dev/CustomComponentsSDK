//  Created by Alessandro Comparini on 29/08/23.
//

import UIKit
import SwiftUI

final class ButtonBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//  MARK: - LAZY AREA
    lazy var buttonPrimary: ButtonBuilder = {
        let btn = ButtonBuilder("Button Primary")
            .setTitleColor(hexColor: "#FFFFFF")
            .setBackgroundColor(hexColor: "#4682A9")
            .setTitleSize(24)
            .setTitleWeight(.regular)
            .setFontFamily("Roboto", 24)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(20)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(55)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return btn
    }()
    
    lazy var buttonCustomize: ButtonBuilder = {
        let btn = ButtonBuilder("Button Customize")
            .setTitleColor(hexColor: "#FFFFFF")
            .setBackgroundColor(hexColor: "#007bfc")
            .setTitleSize(20)
            .setTitleWeight(.semibold)
            .setBorder { build in
                build
                    .setCornerRadius(12)
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(buttonPrimary.get, .bottom, 10)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(55)
            }
        return btn
    }()
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        backgroundColor = .red
        
        addSubview(buttonPrimary.get)
        buttonPrimary.applyConstraint()
        
        addSubview(buttonCustomize.get)
        buttonCustomize.applyConstraint()
        
    }
    
}



//  MARK: - PREVIEW AREA

#if DEBUG
struct ButtonBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        ButtonBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 400)
        .padding(15)
    }
}
#endif
