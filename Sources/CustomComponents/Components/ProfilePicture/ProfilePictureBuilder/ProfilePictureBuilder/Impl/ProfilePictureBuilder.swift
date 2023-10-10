//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit

open class ProfilePictureBuilder: BaseBuilder, ProfilePicture {
    public typealias T = UIView
    public var get: UIView { self.profilePicture.get }
    
    private var chooseSource: ProfileChooseSourceBuilder?
    private var size: CGFloat?
    private var image: ImageViewBuilder?
    
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
        setPlaceHolderImage(ImageViewBuilder(systemName: "camera.viewfinder"))
        setSizePlaceHolderImage(size/2)
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

    lazy var placeHolderImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setContentMode(.scaleAspectFill)
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
        comp.get.clipsToBounds = true
        comp.get.layer.masksToBounds = true
        return comp
    }()

    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setPlaceHolderImage(_ image: ImageViewBuilder?) -> Self {
        guard let image else {return self}
        placeHolderImage.get.image = image.get.image
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
        let img = placeHolderImage.setSize(size)
        placeHolderImage.get.image = img.get.image
        return self
    }
    
    @discardableResult
    public func setTintColor(color: UIColor) -> Self {
        placeHolderImage.setTintColor(color: color)
        return self
    }
    
    @discardableResult
    public func setTintColor(_ hexColor: String) -> Self {
        guard hexColor.isHexColor() else {return self}
        setTintColor(color: UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setChooseSource(viewController: UIViewController, _ builder: (_ build: ProfileChooseSourceBuilder) -> ProfileChooseSourceBuilder) -> Self {
        chooseSource = builder(ProfileChooseSourceBuilder(viewController: viewController, profilePicture: self ))
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
        addElements()
        configConstraints()
        configCircleProfilePicture()
        setPlaceHolderImage(image)
        configTapGesture()
        
        placeHolderImage.get.clipsToBounds = true
    }
    
    private func addElements() {
        backgroundView.add(insideTo: profilePicture.get)
        placeHolderImage.add(insideTo: profilePicture.get)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        placeHolderImage.applyConstraint()
    }
    
    private func configCircleProfilePicture() {
        setCornerRadius((self.size ?? 0) / 2)
    }
    
    private func configTapGesture() {
        TapGestureBuilder(profilePicture)
            .setTap { [weak self] tapGesture in
                self?.chooseSource?.show()
            }
    }

}
