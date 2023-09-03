//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

open class TextFieldImageBuilder: TextFieldBuilder, TextFieldImage {
    
    private var imagePosition: K.Position.Horizontal!
    public var imageView: ImageViewBuilder
    
    
//  MARK: - INITIALIZERS
    
    public override init() {
        imageView = ImageViewBuilder()
        super.init()
        configure()
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setImage(_ image: ImageViewBuilder, _ position: K.Position.Horizontal = .left, _ margin: CGFloat = K.Default.paddingWithImage) -> Self {
        imageView = image
        imageView.setContentMode(.center)
        imagePosition = position
        let paddingView = ViewBuilder(frame: createFrame(margin))
        imageView.setFrame(createFrame(margin))
        imageView.setTranslatesAutoresizingMaskIntoConstraints(true)
        paddingView.get.addSubview(imageView.get)
        setPadding(paddingView, position)
        return self
    }
    
    @discardableResult
    public override func setPadding(_ padding: CGFloat, _ position: K.Position.Horizontal? = nil) -> Self {
        if isSamePositionImage(position) {
            return self
        }
        let position: K.Position.Horizontal = calculatePaddingPosition(position)
        super.setPadding(padding, position)
        return self
    }
    
    @discardableResult
    public func setImageSize(_ size: CGFloat, _ weight: K.Weight? = nil) -> Self {
        imageView.get.image = imageView.get.image?
            .withConfiguration( UIImage.SymbolConfiguration(pointSize: size,
                                                            weight: UIImage.SymbolWeight.init(
                                                                rawValue: weight?.rawValue ?? K.Default.weight.rawValue) ?? .regular ))
        return self
    }
    
    @discardableResult
    public func setIsHideImage(_ hide: Bool) -> Self {
        self.imageView.get.isHidden = hide
        return self
    }
    
    @discardableResult
    public func setImageColor(hexColor: String) -> Self {
        self.imageView.get.tintColor = UIColor.HEX(hexColor)
        return self
    }
    
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        super.setPadding(K.Default.padding)
    }
    
    private func createFrame(_ margin: CGFloat, _ height: CGFloat = .zero) -> CGRect {
        return CGRect(x: .zero,
                      y: .zero,
                      width: (self.imageView.get.image?.size.width ?? .zero) + margin,
                      height: (self.imageView.get.image?.size.height ?? .zero) + height )
    }
    
    private func isSamePositionImage(_ position: K.Position.Horizontal? = nil) -> Bool {
        return imagePosition == position
    }
    
    private func calculatePaddingPosition(_ position: K.Position.Horizontal? = nil) -> K.Position.Horizontal {
        guard let position else { return oppositeImagePosition() }
        return position
    }
    
    private func oppositeImagePosition() -> K.Position.Horizontal {
        switch self.imagePosition {
            case .left:
                return .right
            case .right:
                return .left
            case .none:
                return .left
        }
    }
    
    
}
