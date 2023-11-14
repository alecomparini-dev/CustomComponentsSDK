//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

public class ImageViewBuilder: BaseBuilder, ImageView {
    public typealias T = UIImageView
    public var get: UIImageView { self.imageView}
    
    private var imageView: UIImageView
    
    
//  MARK: - INITIALIZERS

    public init(systemName: String) {
        self.imageView = UIImageView()
        super.init(imageView)
        self.setImage(systemName: systemName)
    }

    public convenience init() {
        self.init(systemName: "")
    }
    
        
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setImage(image: UIImage?) -> Self {
        imageView.image = image
        return self
    }
    
    @discardableResult
    public func setImage(systemName: String) -> Self {
        setImage(image: UIImage(systemName: systemName))
        return self
    }
    
    @discardableResult
    public func setImage(named: String) -> Self {
        setImage(image: UIImage(named: named))
        return self
    }
    
    @discardableResult
    public func setContentMode(_ contentMode: K.ContentMode) -> Self {
        imageView.contentMode = UIView.ContentMode.init(rawValue: contentMode.rawValue) ?? .scaleAspectFill
        return self
    }
    
    @discardableResult
    public func setTintColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        imageView.image = self.imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.image?.withTintColor(color)
        imageView.tintColor = color
        return self
    }
    
    @discardableResult
    public func setTintColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setTintColor(UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setTintColor(named color: String?) -> Self {
        guard let color, let namedColor = UIColor(named: color) else {return self}
        setTintColor(namedColor)
        return self
    }
        
    @discardableResult
    public func setSize(_ size: CGFloat) -> Self {
        imageView.image = imageView.image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        return self
    }
    
    @discardableResult
    public func setWeight(_ weight: K.Weight) -> Self {
        let weight = UIImage.SymbolWeight.init(rawValue: weight.rawValue) ?? .regular
        imageView.image = imageView.image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(weight: weight))
        return self
    }
    
    
}
