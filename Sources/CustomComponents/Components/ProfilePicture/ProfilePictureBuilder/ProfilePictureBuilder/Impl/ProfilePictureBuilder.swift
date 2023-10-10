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
    
    public init(size: CGFloat, image: ImageViewBuilder? = nil) {
        self.profilePicture = ViewBuilder()
        self.size = size
        self.placeHolderImage = image
        super.init(profilePicture.get)
        configure()
        
        if let placeHolderImage {
//            _ = ProfilePictureActionBuilder(component: placeHolderImage)
//                .setTap({ component, tapGesture in
//                    print("DALEEEEEEEEEEE")
//                })
//
            
            TapGestureBuilder(placeHolderImage)
                .setCancelsTouchesInView(false)
                .setTap { tapGesture in
                    print("asdfasdfasdfasdf")
                }
        }
        
    }
    
    public convenience init(size: CGFloat) {
        self.init(size: size, image: nil)
        setSizePlaceHolderImage(size/2)
        if let placeHolderImage {
//            _ = ProfilePictureActionBuilder(component: placeHolderImage)
//                .setTap({ component, tapGesture in
//                    print("DALEEEEEEEEEEE")
//                })
//
            
            TapGestureBuilder(placeHolderImage)
                .setCancelsTouchesInView(false)
                .setTap { tapGesture in
                    print("asdfasdfasdfasdf")
                }
        }
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

/*
    lazy var placeHolderImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setContentMode(.center)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
*/
    
    
    
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
        
        
    }
    
    private func configPlaceHolderImage() {
        if placeHolderImage == nil {
            placeHolderImage = ImageViewBuilder(systemName: "camera.viewfinder")
        }
        
        if let placeHolderImage {
            placeHolderImage
                .setContentMode(.center)
                .setConstraints { build in
                    build
                        .setPin.equalToSuperView
                }
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
