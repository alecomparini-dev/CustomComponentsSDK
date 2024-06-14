//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

@MainActor
open class TextFieldPasswordBuilder: TextFieldImageBuilder, TextFieldPassword {
    
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
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setCloseEye() -> Self {
        closeEye()
        return self
    }
    
    @discardableResult
    public func setOpenEye() -> Self {
        openEye()
        return self
    }
    
    
//  MARK: - PRIVATE AREA

    private func configure() {
        self
            .setIsSecureText(true)
            .setImage(ImageViewBuilder(systemName: K.Images.eyeSlash), .right, paddingRightImage)
            .setPlaceHolderColor(UIColor.systemGray)
            .setTextColor(.black)
            .setTintColor(.black)
            .setActions({ build in
                build
                    .setTapImageRight { [weak self] _ in
                        guard let self else {return}
                        self.openCloseEyes()
                    }
            })
    }
    
    private func openCloseEyes() {
        if super.get.isSecureTextEntry {
            openEye()
            return
        }
        closeEye()
    }
    
    private func openEye() {
        setImage(ImageViewBuilder(systemName: K.Images.eye), .right, paddingRightImage)
        setIsSecureText(false)
    }
    
    private func closeEye() {
        setImage(ImageViewBuilder(systemName: K.Images.eyeSlash), .right, paddingRightImage)
        setIsSecureText(true)
    }
    
}
