//
//  File.swift
//  
//
//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

public protocol TextFieldImage {

//    var imageView: ImageView
    
    func setImageSize(_ size: CGFloat, _ weight: K.Weight?) -> Self
    
    func setIsHideImage(_ hide: Bool) -> Self

    func setImageColor(hexColor: String) -> Self
//
//    override func setPadding(_ padding: CGFloat, _ position: TextField.Position? = nil) -> Self {
//        if isImagePositionMatch(position) {
//            return self
//        }
//        let position: TextField.Position = calculatePaddingPosition(position)
//        super.setPadding(padding, position)
//        return self
//    }
//
//    @discardableResult
//    func setImage(_ image: UIImageView, _ position: TextField.Position, _ margin: CGFloat) -> Self {
//        paddingView = self.createPaddingView(image, margin)
//        self.setFrameImage(image)
//        self.addImageInsidePaddingView(image, paddingView)
//        self.setImageAlignmentInPaddingView(image, paddingView, position)
//        super.setPadding(paddingView, position)
//        setTintColor(self.textField.textColor ?? .black)
//        return self
//    }

    
}
