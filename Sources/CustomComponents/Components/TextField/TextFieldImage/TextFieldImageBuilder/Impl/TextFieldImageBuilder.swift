//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

open class TextFieldImageBuilder: TextFieldBuilder, TextFieldImage {
        
    private var imagePosition: K.Position.Horizontal!
    private var margin: CGFloat = K.Default.paddingWithImage
    private var sizeImage: CGFloat?
    
    public var imageViewLeft: ImageViewBuilder?
    public var imageViewRight: ImageViewBuilder?
    
    
//  MARK: - INITIALIZERS
    
    public init(_ placeHolder: String) {
        super.init()
        super.setPlaceHolder(placeHolder)
        configure()
    }
    
    public convenience override init() {
        self.init("")
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setImage(_ image: ImageViewBuilder,  _ position: K.Position.Horizontal = .left, _ margin: CGFloat = K.Default.paddingWithImage) -> Self {
        switch position {
        case .left:
            setImageLeft(image, margin)
        case .right:
            setImageRight(image, margin)
        }
        setTintColor(color: super.get.textColor)
        return self
    }
    
    private func setImageLeft(_ image: ImageViewBuilder, _ margin: CGFloat = K.Default.paddingWithImage) {
        imageViewLeft = ImageViewBuilder()
        updateImageView(image, position: .left)
        imageViewLeft?.setContentMode(.center)
        createPaddingView(.left)
    }

    private func setImageRight(_ image: ImageViewBuilder, _ margin: CGFloat = K.Default.paddingWithImage) {
        imageViewRight = ImageViewBuilder()
        updateImageView(image, position: .right)
        imageViewRight?.setContentMode(.center)
        createPaddingView(.right)
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
        imageViewLeft?.get.image = imageViewLeft?.get.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        if let imageViewLeft {
            setImageLeft(imageViewLeft, margin)
        }
        
        imageViewRight?.get.image = imageViewRight?.get.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        if let imageViewRight {
            setImageRight(imageViewRight, margin)
        }
        return self
    }
    
    @discardableResult
    public func setIsHideImage(_ hide: Bool, position: K.Position.Horizontal? = nil) -> Self {
        switch position {
        case .left:
            imageViewLeft?.get.isHidden = hide
        case .right:
            imageViewRight?.get.isHidden = hide
        case .none:
            imageViewLeft?.get.isHidden = hide
            imageViewRight?.get.isHidden = hide
        }
        return self
    }
    
    @discardableResult
    public func setImageColor(hexColor: String?, position: K.Position.Horizontal? = nil) -> Self {
        guard let hexColor else {return self}
        switch position {
        case .left:
            imageViewLeft?.get.tintColor = UIColor.HEX(hexColor)
        case .right:
            imageViewRight?.get.tintColor = UIColor.HEX(hexColor)
        case .none:
            imageViewLeft?.get.tintColor = UIColor.HEX(hexColor)
            imageViewRight?.get.tintColor = UIColor.HEX(hexColor)
        }
        return self
    }
    
    
//  MARK: - SET ACTIONS
    
    @discardableResult
    public func setActions(_ builder: (_ build: TextFieldImageActionBuilder) -> TextFieldImageActionBuilder) -> Self {
        if let imageViewLeft {
            _ = builder(TextFieldImageActionBuilder(component: imageViewLeft ))
        }
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        super.setPadding(K.Default.padding)
        self
            .setPlaceHolderColor(color: UIColor.systemGray)
            .setTextColor(color: .black)
            .setTintColor(color: .black)
    }
    
    private func saveData(_ position: K.Position.Horizontal, _ margin: CGFloat) {
        self.imagePosition = position
        self.margin = margin
    }
    
    private func getImageView(_ position: K.Position.Horizontal) -> ImageViewBuilder? {
        switch position {
            case .left:
                return imageViewLeft
            case .right:
                return imageViewRight
        }
    }
    
    private func updateImageView(_ image: ImageViewBuilder, position: K.Position.Horizontal) {
        guard var imgView = getImageView(position) else {return}
        
        switch position {
        case .left:
            if imageViewLeft?.get.image != nil {
                imageViewLeft?.get.image = image.get.image
            } else {
                imageViewLeft = image
            }
            
            if let sizeImage {
                imageViewLeft?.get.image = imageViewLeft?.get.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: sizeImage))
            }
        case .right:
            if imageViewRight?.get.image != nil {
                imageViewRight?.get.image = image.get.image
            } else {
                imageViewRight = image
            }
            
            if let sizeImage {
                imageViewRight?.get.image = imageViewRight?.get.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: sizeImage))
            }
            
        }
        
        
        
        
    }
    
    private func createPaddingView(_ position: K.Position.Horizontal) {
        guard let imgView: ImageViewBuilder = getImageView(position) else {return}
        let frame = createFrame(self.margin, position: position)
        let paddingView = ViewBuilder(frame: frame)
        imgView.setFrame(frame)
        imgView.setTranslatesAutoresizingMaskIntoConstraints(true)
        paddingView.get.addSubview(imgView.get)
        setPadding(paddingView, position)
    }
    
    private func createFrame(_ margin: CGFloat, position: K.Position.Horizontal) -> CGRect {
        guard let imgView: ImageViewBuilder = getImageView(position) else {return .zero}
        let doubleMargin = margin * 2
        return CGRect(x: .zero,
                      y: .zero,
                      width: (imgView.get.image?.size.width ?? .zero) + doubleMargin ,
                      height: (imgView.get.image?.size.width ?? .zero) + doubleMargin)
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
