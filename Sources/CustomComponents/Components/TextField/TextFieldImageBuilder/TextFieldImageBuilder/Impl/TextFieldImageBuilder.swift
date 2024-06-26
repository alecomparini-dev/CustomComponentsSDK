//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

@MainActor
open class TextFieldImageBuilder: TextFieldBuilder, TextFieldImage {
        
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
    
    public override init() {
        super.init()
    }
    
    deinit{
//        action = nil
        imageViewLeft = nil
        imageViewRight = nil
        sizeImage = nil
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setImage(_ image: ImageViewBuilder,  _ position: K.Position.Horizontal = .left, _ margin: CGFloat = K.Default.paddingWithImage) -> Self {
        self.margin = margin
        switch position {
        case .left:
            setImageLeft(image)
        case .right:
            setImageRight(image)
        case .both:
            setImageLeft(image)
            setImageRight(image)
        }
        return self
    }

    @discardableResult
    public override func setPadding(_ padding: CGFloat?, _ position: K.Position.Horizontal? = .left) -> Self {
        guard let padding else {return self}
        super.setPadding(padding, position)
        return self
    }
    
    @discardableResult
    public func setImageSize(_ size: CGFloat?, _ weight: K.Weight? = nil) -> Self {
        guard let size else {return self}
        sizeImage = size
        imageViewLeft?.get.image = imageViewLeft?.get.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        if let imageViewLeft {
            setImageLeft(imageViewLeft)
        }
        
        imageViewRight?.get.image = imageViewRight?.get.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        if let imageViewRight {
            setImageRight(imageViewRight)
        }
        return self
    }
    
    @discardableResult
    public func setIsHideImage(_ hide: Bool, position: K.Position.Horizontal = .both) -> Self {
        switch position {
        case .left:
            imageViewLeft?.get.isHidden = hide
        case .right:
            imageViewRight?.get.isHidden = hide
        case .both:
            imageViewLeft?.get.isHidden = hide
            imageViewRight?.get.isHidden = hide
        }
        return self
    }

    @discardableResult
    public func setImageColor(_ color: UIColor, position: K.Position.Horizontal = .both) -> Self {
        switch position {
            case .left:
                imageViewLeft?.get.tintColor = color
            case .right:
                imageViewRight?.get.tintColor = color
            case .both:
                imageViewLeft?.get.tintColor = color
                imageViewRight?.get.tintColor = color
        }
        return self
    }
    
    @discardableResult
    public func setImageColor(hexColor color: String?, position: K.Position.Horizontal = .both) -> Self {
        guard let color, color.isHexColor() else {return self}
        setImageColor(UIColor.HEX(color), position: position)
        return self
    }
    
    
//  MARK: - SET ACTIONS

    @discardableResult
    public func setActions(textFieldImage action: (_ build: TextFieldImageActionBuilder) -> TextFieldImageActionBuilder) -> Self {
        _ = action(TextFieldImageActionBuilder(self))
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        super.setPadding(K.Default.padding)
        self
            .setPlaceHolderColor(UIColor.systemGray)
            .setTextColor(.black)
            .setTintColor(.black)
    }
    
    private func getImageView(_ position: K.Position.Horizontal) -> ImageViewBuilder? {
        switch position {
            case .left:
                if imageViewLeft == nil {
                    imageViewLeft = ImageViewBuilder()
                }
                return imageViewLeft
            
            case .right:
                if imageViewRight == nil {
                    imageViewRight = ImageViewBuilder()
                }
                return imageViewRight
            
            case .both:
                return nil
        }
    }
    
    private func updateImageView( _ newImage: ImageViewBuilder, _ position: K.Position.Horizontal) {
        switch position {
            case .left:
                if imageViewLeft?.get.image != nil {
                    imageViewLeft?.get.image = newImage.get.image
                } else {
                    imageViewLeft = ImageViewBuilder()
                    imageViewLeft = newImage
                }
                if let sizeImage {
                    imageViewLeft?.get.image = imageViewLeft?.get.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: sizeImage))
                }
            
            case .right:
                if imageViewRight?.get.image != nil {
                    imageViewRight?.get.image = newImage.get.image
                } else {
                    imageViewRight = ImageViewBuilder()
                    imageViewRight = newImage
                }
                if let sizeImage {
                    imageViewRight?.get.image = imageViewRight?.get.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: sizeImage))
                }
            
            case .both:
                updateImageView(newImage,.left)
                updateImageView(newImage,.right)
        }
    }
    
    private func createPaddingView(_ position: K.Position.Horizontal) {
        guard let imgView: ImageViewBuilder = getImageView(position) else {return}
        let frame = createFrame(self.margin, position: position)
        let paddingView = ViewBuilder(frame: frame)
        imgView.setFrame(frame)
        imgView.setTranslatesAutoresizingMaskIntoConstraints(true)
        imgView.add(insideTo: paddingView.get)
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
    
    private func setImageLeft(_ newImage: ImageViewBuilder) {
        updateImageView(newImage, .left)
        imageViewLeft?.setContentMode(.center)
        createPaddingView(.left)
    }

    private func setImageRight(_ newImage: ImageViewBuilder) {
        updateImageView(newImage, .right)
        imageViewRight?.setContentMode(.center)
        createPaddingView(.right)
    }

    
}
