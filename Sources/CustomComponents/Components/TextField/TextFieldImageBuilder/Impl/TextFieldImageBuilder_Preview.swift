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
    lazy var textField: TextFieldBuilder = {
        let component = TextFieldBuilder("Place Holder")
            .setBackgroundColor(hexColor: "#ffffff")
            .setBorder { build in
                build
                    .setCornerRadius(12)
            }
        return component
    }()

    
    lazy var textFieldImage: TextFieldImageBuilder = {
        let img = ImageViewBuilder(systemName: "mic")
        let component = TextFieldImageBuilder()
//            .setImage(img, .right, 16)
            .setImage(img, .left)
            .setImageSize(22, .bold)
            .setImageColor(hexColor: "#000000")
            .setBackgroundColor(hexColor: "#ffffff")
            .setPlaceHolder("Type here ...")
            .setBorder { build in
                build
                    .setCornerRadius(12)
            }
        return component
    }()
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        backgroundColor = .red
        
        addSubview(textField.get)
        addSubview(textFieldImage.get)
        
        NSLayoutConstraint.activate([
            textField.get.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.get.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            textField.get.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            textField.get.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            textField.get.heightAnchor.constraint(equalToConstant: 45),
            
            textFieldImage.get.topAnchor.constraint(equalTo: textField.get.bottomAnchor, constant: 10),
            textFieldImage.get.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            textFieldImage.get.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            textFieldImage.get.heightAnchor.constraint(equalToConstant: 45)
        ])
        
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
