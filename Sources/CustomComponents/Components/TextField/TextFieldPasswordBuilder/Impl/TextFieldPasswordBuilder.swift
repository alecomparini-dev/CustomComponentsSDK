//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

open class TextFieldPasswordBuilder: TextFieldImageBuilder {
    
    
//  MARK: - Initializers

    public init(paddingRightImage: CGFloat = K.Default.paddingWithImage) {
        super.init("")
        self.setIsSecureText(true)
            .setImage(ImageViewBuilder(systemName: "eye.slash"), .right, paddingRightImage)
    }
    
    public convenience override init(_ placeHolder: String) {
        self.init()
        super.setPlaceHolder(placeHolder)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - ACTIONS THIS COMPONENT

    private func openCloseEyes(_ imageView: UIImageView) {
        var systemName = "eye.slash"
        if super.get.isSecureTextEntry {
            systemName = "eye"
        }
        imageView.image = UIImage(systemName: systemName)
        self.setIsSecureText(!super.get.isSecureTextEntry)
    }
    
}
