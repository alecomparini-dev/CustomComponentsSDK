//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit
import SwiftUI

final class TextFieldImageBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//  MARK: - LAZY AREA
    lazy var textField: TextFieldImageBuilder = {
        let img = ImageViewBuilder(systemName: "person")
        let component = TextFieldImageBuilder()
            .setImage(img, .left, 8)
            .setImageSize(22, .bold)
            .setImageColor(hexColor: "#000000")
            .setBackgroundColor(hexColor: "#ffffff")
            .setBorder { build in
                build
                    .setCornerRadius(8)
            }
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
        let imgPerson = ImageViewBuilder(systemName: "person")
        let component = TextFieldImageBuilder()
            .setImage(img, .right, 8)
            .setImage(imgPerson, .left, 8)
            .setImageSize(22, .bold)
            .setTintColor(hexColor: "#000000")
            .setImageColor(hexColor: "#000000")
            .setBackgroundColor(hexColor: "#ffffff")
            .setPlaceHolder("Type here ...")
            .setBorder { build in
                build
                    .setCornerRadius(8)
            }
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
        
        textField.add(insideTo: self)
        textField.applyConstraint()
        
        textFieldImage.add(insideTo: self)
        textFieldImage.applyConstraint()
                
    }
    
}



//  MARK: - PREVIEW AREA

#if DEBUG
struct TextFieldImageBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        TextFieldImageBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 400)
        .padding(15)
    }
}
#endif
