//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

open class TextFieldImageBuilder: TextFieldBuilder, TextFieldImage {
    
    private var imagePosition: K.Position.Horizontal!
    private var margin: CGFloat = K.Default.paddingWithImage
    private var sizeImage: CGFloat?
    
    public var imageView: ImageViewBuilder
    
    
//  MARK: - INITIALIZERS
    
    public init(_ placeHolder: String) {
        self.imageView = ImageViewBuilder()
        super.init()
        super.setPlaceHolder(placeHolder)
        configure()
    }
    
    public convenience override init() {
        self.init("")
    }
    
    private func saveData(_ position: K.Position.Horizontal, _ margin: CGFloat) {
        self.imagePosition = position
        self.margin = margin
    }
    
    
    private func updateImageView(_ image: ImageViewBuilder) {
        if imageView.get.image != nil {
            imageView.get.image = image.get.image
        } else {
            imageView = image
        }
        
        if let sizeImage {
            imageView.get.image = imageView.get.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: sizeImage))
        }
    }
    
    private func createPaddingView() {
        let frame = createFrame(self.margin)
        let paddingView = ViewBuilder(frame: frame)
        imageView.setFrame(frame)
        imageView.setTranslatesAutoresizingMaskIntoConstraints(true)
        paddingView.get.addSubview(imageView.get)
        setPadding(paddingView, self.imagePosition)
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setImage(_ image: ImageViewBuilder, _ position: K.Position.Horizontal = .left, _ margin: CGFloat = K.Default.paddingWithImage) -> Self {
        saveData(position, margin)
        updateImageView(image)
        imageView.setContentMode(.center)
        createPaddingView()
        setTintColor(color: super.get.textColor)
        return self
    }

    @discardableResult
    public override func setPadding(_ padding: CGFloat?, _ position: K.Position.Horizontal? = nil) -> Self {
        guard let padding else {return self}
        if isSamePositionImage(position) {
            return self
        }
        let position: K.Position.Horizontal = calculatePaddingPosition(position)
        super.setPadding(padding, position)
        return self
    }
    
    @discardableResult
    public func setImageSize(_ size: CGFloat?, _ weight: K.Weight? = nil) -> Self {
        guard let size else {return self}
        sizeImage = size
        imageView.get.image = imageView.get.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        setImage(imageView, imagePosition, margin)
        return self
    }
    
    @discardableResult
    public func setIsHideImage(_ hide: Bool) -> Self {
        imageView.get.isHidden = hide
        return self
    }
    
    @discardableResult
    public func setImageColor(hexColor: String?) -> Self {
        guard let hexColor else {return self}
        imageView.get.tintColor = UIColor.HEX(hexColor)
        return self
    }
    
    
//  MARK: - SET ACTIONS
    
    @discardableResult
    public func setActions(_ builder: (_ build: TextFieldImageActionBuilder) -> TextFieldImageActionBuilder) -> Self {
        _ = builder(TextFieldImageActionBuilder(component: imageView ))
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        super.setPadding(K.Default.padding)
    }
    
    private func createFrame(_ margin: CGFloat) -> CGRect {
        let doubleMargin = margin * 2
        return CGRect(x: .zero,
                      y: .zero,
                      width: (imageView.get.image?.size.width ?? .zero) + doubleMargin ,
                      height: (imageView.get.image?.size.width ?? .zero) + doubleMargin)
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
