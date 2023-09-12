//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit
import SwiftUI

final class TextFieldPasswordBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//  MARK: - LAZY AREA
    lazy var textField: TextFieldPasswordBuilder = {
        let component = TextFieldPasswordBuilder(paddingRightImage: 8)
            .setBackgroundColor(hexColor: "#ffffff")
            .setBorder { build in
                build
                    .setCornerRadius(8)
            }
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSafeArea
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(45)
            }        
        return component
    }()
    
    lazy var textFieldImg: TextFieldImageBuilder = {
        let component = TextFieldImageBuilder("ImageBuilder")
            .setBackgroundColor(hexColor: "#ffffff")
            .setImage(ImageViewBuilder(systemName: "mic"), .right, 8)
            .setBorder { build in
                build
                    .setCornerRadius(8)
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(textField.get, .bottom, 10)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(45)
            }
            .setActions { build in
                build
                    .setTap { component, tapGesture in
                        print(tapGesture?.getTouchPosition(.component) ?? "")
                    }
            }
        return component
    }()


    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        backgroundColor = .red
        
        addSubview(textField.get)
        addSubview(textFieldImg.get)
        textField.applyConstraint()
        textFieldImg.applyConstraint()

        
    }
    
}



//  MARK: - PREVIEW AREA

#if DEBUG
struct TextFieldPasswordBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        TextFieldPasswordBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 400)
        .padding(15)
    }
}
#endif
