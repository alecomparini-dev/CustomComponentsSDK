//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

class TextFieldPasswordBuilder: TextFieldImageBuilder {
    
    
//  MARK: - Initializers

    init(paddingRightImage: CGFloat = K.Default.paddingWithImage) {
        super.init()
        self.setIsSecureText(true)
            .setImage(ImageViewBuilder(systemName: "eye.slash"), .right, paddingRightImage)
    }
    
    convenience init(_ placeHolder: String) {
        self.init()
        super.setPlaceHolder(placeHolder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - ACTIONS THIS COMPONENT

    private func openCloseEyes(_ imageView: UIImageView) {
        if super.get.isSecureTextEntry {
            imageView.image = UIImage(systemName: "eye")
        } else {
            imageView.image = UIImage(systemName: "eye.slash")
        }
        self.setIsSecureText(!super.get.isSecureTextEntry)
    }
    
}
