//  Created by Alessandro Comparini on 13/09/23.
//

import UIKit

open class ButtonImageBuilderImpl: ButtonBuilder, ButtonImageBuilder {
    public var imageView: ImageViewBuilder

    public override init() {
        self.imageView = ImageViewBuilder()
    }
    
    @discardableResult
    public func setImageButton(_ image: ImageViewBuilder) -> Self {
        guard let image = image.get.image else {return self}
        super.get.setImage(image, for: .normal)
        super.get.imageView?.contentMode = .scaleAspectFit
        return self
    }

    @discardableResult
    public func setImageColor(color: UIColor?) -> Self {
        super.get.imageView?.tintColor = color
        return self
    }
    
    @discardableResult
    public func setImageColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        super.get.imageView?.tintColor = UIColor.HEX(color)
        return self
    }
    
    @discardableResult
    public func setImageColor(named color: String?) -> Self {
        let img = ImageViewBuilder()
        img.get.image = imageView.get.image
        img.setTintColor(named: color )
        setImageButton(img)
        return self
    }
    
    @discardableResult
    public func setImageSize(_ size: CGFloat) -> Self {
        let img = ImageViewBuilder()
        img.get.image = imageView.get.image
        img.setSize(size)
        setImageButton(img)
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
    
    
}


