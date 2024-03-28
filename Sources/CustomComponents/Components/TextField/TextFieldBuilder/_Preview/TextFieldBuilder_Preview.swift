//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit
import SwiftUI

final class TextFieldBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    lazy var textField: TextFieldBuilder = {
        let component = TextFieldBuilder(placeHolder: "Place Holder")
            .setBackgroundColor(hexColor: "#ffffff")
            .setBorder { build in
                build
                    .setCornerRadius(8)
            }
            .setMask({ build in
                build
                    .setDateMask()
                    .setCellPhoneNumberMask()
            })
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(20)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(45)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return component
    }()

    
    lazy var textFieldImage: TextFieldImageBuilder = {
        let img = ImageViewBuilder(systemName: "mic")
        let component = TextFieldImageBuilder()
            .setImage(img, .left)
            .setImageSize(22, .bold)
            .setImageColor(hexColor: "#000000")
            .setBackgroundColor(hexColor: "#ffffff")
            .setPlaceHolder("Type here ...")
            .setBorder { build in
                build
                    .setCornerRadius(18)
            }
            .setShadow({ build in
                build
                    .setColor(.black)
                    .setOffset(width: 3, height: 3)
                    .setRadius(5)
            })
//            .setBorder { build in
//                build
//                    .setCornerRadius(8)
//            }
            .setConstraints { build in
                build
                    .setTop.equalTo(textField.get, .bottom, 20)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(55)
            }
        return component
    }()
    
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        backgroundColor = .red
        
        addSubview(textField.get)
        textField.applyConstraint()

        addSubview(textFieldImage.get)
        textFieldImage.applyConstraint()
        
    }
    
}



//  MARK: - PREVIEW AREA

#if DEBUG
struct TextFieldBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        TextFieldBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 400)
        .padding(15)
    }
}
#endif
