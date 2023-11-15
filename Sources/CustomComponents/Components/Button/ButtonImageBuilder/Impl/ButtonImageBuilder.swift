//  Created by Alessandro Comparini on 13/09/23.
//

import UIKit

open class ButtonImageBuilder: ButtonBuilder, ButtonImage {
    public var imageView: ImageViewBuilder

    
    public init(_ imageViewBuilder: ImageViewBuilder) {
        self.imageView = imageViewBuilder
        super.init()
        self.setImageButton(imageViewBuilder)
    }
    
    public convenience override init() {
        self.init(ImageViewBuilder())
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setImageButton(_ image: ImageViewBuilder) -> Self {
        self.imageView = image
        if let image = image.get.image {
//            super.get.setImage(image, for: .normal)
            super.get.imageView?.image = image
        }
        return self
    }

    @discardableResult
    public func setImageColor(_ color: UIColor?) -> Self {
        super.get.tintColor = color
        return self
    }
    
    @discardableResult
    public func setImageColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setImageColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setImageColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setImageColor( namedColor)
        return self
    }
    
    @discardableResult
    public func setImageWeight(_ weight: K.Weight) -> Self {
        let img = ImageViewBuilder()
        img.get.image = imageView.get.image
        img.setWeight(weight)
        setImageButton(img)
        return self
    }
    
    @discardableResult
    public func setImageSize(_ size: CGFloat?) -> Self {
        guard let size else {return self}
        let imageView = ImageViewBuilder().setImage(image: super.get.image(for: .normal)).setSize(size)
        setImageButton(imageView)
        return self
    }
    
    
}


