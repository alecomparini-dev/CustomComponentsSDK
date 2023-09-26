//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

open class TextFieldPasswordBuilder: TextFieldImageBuilder {
    
    private let paddingRightImage: CGFloat
    
    
//  MARK: - INITIALIZERS

    public init(paddingRightImage: CGFloat = K.Default.paddingWithImage) {
        self.paddingRightImage = paddingRightImage
        super.init("")
        configure()
    }
    
    public convenience override init(_ placeHolder: String) {
        self.init()
        super.setPlaceHolder(placeHolder)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - PRIVATE AREA

    private func configure() {
        self
            .setIsSecureText(true)
            .setImage(ImageViewBuilder(systemName: K.Images.eyeSlash), .right, paddingRightImage)
            .setPlaceHolderColor(color: UIColor.systemGray)
            .setTextColor(color: .black)
            .setTintColor(color: .black)
            .setActions(imagePosition: .right) { build in
                build
                    .setTap { [weak self] component, tapGesture in
                        guard let self else {return}
                        self.openCloseEyes(component as! ImageViewBuilder )
                    }
            }
    }
    
    private func openCloseEyes(_ imageView: ImageViewBuilder) {
        var systemName = K.Images.eyeSlash
        if super.get.isSecureTextEntry {
            systemName = K.Images.eye
        }
        setImage(ImageViewBuilder(systemName: systemName), .right, paddingRightImage)
        setIsSecureText(!super.get.isSecureTextEntry)
    }
    
}
