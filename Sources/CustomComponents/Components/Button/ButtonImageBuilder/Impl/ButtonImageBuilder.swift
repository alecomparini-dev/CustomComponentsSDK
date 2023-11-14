//  Created by Alessandro Comparini on 13/09/23.
//

import UIKit

open class ButtonImageBuilder: ButtonBuilder, ButtonImage {
    public var imageView: ImageViewBuilder

    public override init() {
        self.imageView = ImageViewBuilder()
    }
    
    @discardableResult
    public func setImageButton(_ image: ImageViewBuilder) -> Self {
        self.imageView = image
        guard let image = image.get.image else {return self}
        super.get.setImage(image, for: .normal)
        super.get.imageView?.contentMode = .scaleAspectFit
        return self
    }

    @discardableResult
    public func setImageColor(color: UIColor?) -> Self {
        super.get.tintColor = color
        return self
    }
    
    @discardableResult
    public func setImageColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setImageColor(color: UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setImageColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setImageColor(color: namedColor)
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


