//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit

open class ProfilePictureBuilder: BaseBuilder, ProfilePicture {
    public typealias T = UIView
    public var get: UIView { self.profilePicture.get }
    
    private var size: CGFloat?
    
    private var placeHolderImage: ImageViewBuilder?
    
    private var profilePicture: ViewBuilder
    
    
//  MARK: - INITIALIZERS
    
    public init(size: CGFloat) {
        self.profilePicture = ViewBuilder()
        self.size = size
        super.init(profilePicture.get)
        configure()
    }
    
    public convenience init(size: CGFloat, image: ImageViewBuilder) {
        self.init(size: size)
        setPlaceHolderImage(image)
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var backgroundView: ViewBuilder = {
        guard let size else { return ViewBuilder()}
        let comp = ViewBuilder(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSafeArea
                    .setSize.equalToConstant(size)
            }
        return comp
    }()
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setPlaceHolderImage(_ image: ImageViewBuilder) -> Self {
        placeHolderImage?.get.image = image.get.image
        return self
    }

    @discardableResult
    public func setCornerRadius(_ radius: CGFloat) -> Self {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundView.setBorder { build in
                build
                    .setCornerRadius(radius)
            }
        }
        return self
    }

    @discardableResult
    public func setSizePlaceHolderImage(_ size: CGFloat) -> Self {
        guard let placeHolderImage else {return self}
        let img = placeHolderImage.setSize(size)
        placeHolderImage.get.image = img.get.image
        return self
    }
    
    @discardableResult
    public func setTintColor(color: UIColor) -> Self {
        placeHolderImage?.setTintColor(color: color)
        return self
    }
    
    @discardableResult
    public func setTintColor(_ hexColor: String) -> Self {
        guard hexColor.isHexColor() else {return self}
        setTintColor(color: UIColor.HEX(hexColor))
        return self
    }
    
    
//  MARK: - OVERRIDE PROPERTIES AREA
    
    @discardableResult
    public override func setBackgroundColor(hexColor: String?) -> Self {
        backgroundView.setBackgroundColor(hexColor: hexColor)
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configPlaceHolderImage()
        addElements()
        configConstraints()
        configCircleProfilePicture()
        setPlaceHolderImage( ImageViewBuilder(systemName: "camera.viewfinder") )
        
        guard let placeHolderImage else {return}
        _ = ProfilePictureActionBuilder(component: placeHolderImage)
            .setTap({ component, tapGesture in
                print("DALE TAP")
            })
        
//        TapGestureBuilder(placeHolderImage)
//            .setTap { tapGesture in
//                print("DALE ATRAS DE DALE")
//            }
    }
    
    private func configPlaceHolderImage() {
        placeHolderImage = ImageViewBuilder()
            .setContentMode(.center)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSafeArea
                    .setSize.equalToConstant(50)
            }
    }
    
    private func addElements() {
        backgroundView.add(insideTo: profilePicture.get)
        placeHolderImage?.add(insideTo: backgroundView.get)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        placeHolderImage?.applyConstraint()
    }
    
    private func configCircleProfilePicture() {
        setCornerRadius((self.size ?? 0) / 2)
    }
}
