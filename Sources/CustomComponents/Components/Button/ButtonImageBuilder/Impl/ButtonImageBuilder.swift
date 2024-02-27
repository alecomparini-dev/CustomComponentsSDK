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
        
    public override init(_ title: String) {
        self.imageView = ImageViewBuilder()
        super.init(title)
    }
    
    public override init() {
        self.imageView = ImageViewBuilder()
        super.init()
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setImageButton(_ image: ImageViewBuilder) -> Self {
        guard let image = image.get.image else {return self}
        if #available(iOS 15.0, *) {
            super.get.configuration?.image = image
        }
        super.get.setImage(image, for: .normal)
        return self
    }
    
    @available(iOS 15.0, *)
    @discardableResult
    public func setImagePlacement(_ alignment: NSDirectionalRectEdge ) -> Self {
        if super.get.titleLabel != nil {
            setImagePadding(8)
        }
        super.get.configuration?.imagePlacement = alignment
        return self
    }

    @discardableResult
    public func setImageColor(_ color: UIColor?) -> Self {
        if #available(iOS 15.0, *) {
            super.get.configuration?.baseForegroundColor = color
        } else {
            super.get.tintColor = color
        }
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
        var img: ImageViewBuilder = ImageViewBuilder()
        if #available(iOS 15.0, *) {
            img = ImageViewBuilder(super.get.configuration?.image).setWeight(weight)
        } else {
            img.get.image = imageView.get.image
            img.setWeight(weight)
        }
        setImageButton(img)
        return self
    }
    
    @discardableResult
    public func setImageSize(_ size: CGFloat?) -> Self {
        guard let size else {return self}
        var img: ImageViewBuilder
        if #available(iOS 15.0, *) {
            img = ImageViewBuilder(super.get.configuration?.image).setSize(size)
        } else {
            img = ImageViewBuilder().setImage(image: super.get.image(for: .normal)).setSize(size)
        }
        setImageButton(img)
        return self
    }
    
    @available(iOS 15.0, *)
    @discardableResult
    public func setImagePadding(_ padding: CGFloat) -> Self {
        super.get.configuration?.imagePadding = padding
        return self
    }
    
    
}


