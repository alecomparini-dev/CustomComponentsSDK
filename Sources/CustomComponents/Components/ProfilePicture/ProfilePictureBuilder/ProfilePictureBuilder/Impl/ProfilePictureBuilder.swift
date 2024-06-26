//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit

@MainActor
open class ProfilePictureBuilder: BaseBuilder, ProfilePicture {
    public typealias T = UIView
    public var get: UIView { self.profilePicture.get }
    
    private var circleProfile: Bool = false
    private let size: CGFloat
    private var image: ImageViewBuilder?

    private var chooseSource: ProfileChooseSourceBuilder?
    
    private let profilePicture: ViewBuilder
    
    
//  MARK: - INITIALIZERS
    
    public init(size: CGFloat, image: ImageViewBuilder? = nil) {
        self.profilePicture = ViewBuilder()
        self.size = size
        self.image = image
        super.init(profilePicture.get)
        configure()
    }
    
    public convenience init(size: CGFloat) {
        self.init(size: size, image: nil)
        profileImage.setContentMode(.center)
        setPlaceHolderImage(ImageViewBuilder(systemName: "camera.viewfinder"))
        setSizePlaceHolderImage(size/2)
    }
    
    
//  MARK: - LAZY AREA
    
    lazy public var profileImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setAutoLayout { build in
                build
                    .pin.equalToSuperview()                
            }
        return comp
    }()

    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setPlaceHolderImage(_ image: ImageViewBuilder?) -> Self {
        guard let image else {return self}
        profileImage.get.image = image.get.image
        return self
    }

    @discardableResult
    public func setCornerRadius(_ radius: CGFloat) -> Self {
        profileImage.setBorder { build in
            build
                .setCornerRadius(radius)
        }
        return self
    }

    @discardableResult
    public func setSizePlaceHolderImage(_ size: CGFloat) -> Self {
        profileImage.setSize(size)
        return self
    }
    
    @discardableResult
    public func setTintColor(_ color: UIColor) -> Self {
        profileImage.setTintColor(color)
        return self
    }
    
    @discardableResult
    public func setTintColor(_ hexColor: String) -> Self {
        guard hexColor.isHexColor() else {return self}
        setTintColor(UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setChooseSource(viewController: UIViewController, _ builder: (_ build: ProfileChooseSourceBuilder) -> ProfileChooseSourceBuilder) -> Self {
        chooseSource = builder(ProfileChooseSourceBuilder(viewController: viewController, profilePicture: self ))
        return self
    }
        
    @discardableResult
    public func setImagePicture(_ image: UIImage) -> Self {
        profileImage.setContentMode(.scaleAspectFill)
        profileImage.setImage(image: image)
        return self
    }
    
    @discardableResult
    public func setImagePicture(_ imageData: Data) -> Self {
        if let image = UIImage(data: imageData) {
            setImagePicture(image)
        }
        return self
    }
    
    @discardableResult
    public func setCircleProfilePicture() -> Self {
        setCornerRadius(size / 2)
        return self
    }

    
    
//  MARK: - OVERRIDE PROPERTIES AREA
    
    @discardableResult
    public override func setBackgroundColor(hexColor: String?) -> Self {
        profileImage.setBackgroundColor(hexColor: hexColor)
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
        setPlaceHolderImage(image)
        configTapGesture()
        configClipsToBounds()
    }
    
    private func configClipsToBounds() {
        profilePicture.get.clipsToBounds = true
    }
    
    private func addElements() {
        profileImage.add(insideTo: profilePicture.get)
    }
    
    private func configConstraints() {
        profileImage.applyAutoLayout()
    }
        
    private func configTapGesture() {
        TapGestureBuilder(profileImage.get)
            .setTap { [weak self] tapGesture in
                self?.chooseSource?.show()
            }
    }

}
