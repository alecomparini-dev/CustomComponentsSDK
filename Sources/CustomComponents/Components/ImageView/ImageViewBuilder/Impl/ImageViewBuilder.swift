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
    public func setImage(systemName: String) -> Self {
        self.imageView.image = UIImage(systemName: systemName)
        return self
    }
    
    @discardableResult
    public func setImage(named: String) -> Self {
        self.imageView.image = UIImage(named: named)
        return self
    }
    
    @discardableResult
    public func setContentMode(_ contentMode: K.ContentMode) -> Self {
        self.imageView.contentMode = UIView.ContentMode.init(rawValue: contentMode.rawValue) ?? .scaleAspectFill
        return self
    }
    
    @discardableResult
    public func setTintColor(hexColor: String) -> Self {
        let color = UIColor.HEX(hexColor)
        self.imageView.image = self.imageView.image?.withRenderingMode(.alwaysTemplate)
        self.imageView.image?.withTintColor(color)
        self.imageView.tintColor = color
        return self
    }
    
    @discardableResult
    public func setSize(_ size: CGFloat) -> Self {
        self.imageView.image = self.imageView.image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        return self
    }
    
    @discardableResult
    public func setWeight(_ weight: K.Weight) -> Self {
        let weight = UIImage.SymbolWeight.init(rawValue: weight.rawValue) ?? .regular
        self.imageView.image = self.imageView.image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(weight: weight))
        return self
    }
    
    
}
