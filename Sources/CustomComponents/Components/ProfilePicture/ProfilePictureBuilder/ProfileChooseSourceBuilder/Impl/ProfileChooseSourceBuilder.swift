//  Created by Alessandro Comparini on 10/10/23.
//

import UIKit

public class ProfileChooseSourceBuilder: BaseBuilder, ProfileChooseSource {
    
    private var alert: UIAlertController!
    private let imagePicker = UIImagePickerController()
    
    private var completionOpenCamera: ProfileChooseSource.completion?
    private var completionOpenGallery: ProfileChooseSource.completion?
    
    private let viewController: UIViewController
    private let profilePicture: ProfilePictureBuilder
    
    public init(viewController: UIViewController, profilePicture: ProfilePictureBuilder) {
        self.viewController = viewController
        self.profilePicture = profilePicture
        super.init(UIView())
        configure()
    }
    

//  MARK: - SET PROPERTIES
    @discardableResult
    public func setTitle(title: String) -> Self {
        alert.title = title
        return self
    }
    
    @discardableResult
    public func setOpenCamera(_ title: String? = nil, completion: completion?) -> Self {
        let cameraAction = UIAlertAction(title: title ?? "Camera", style: .default) { [weak self] _ in
            self?.openCamera()
        }
        alert.addAction(cameraAction)
        return self
    }
    
    @discardableResult
    public func setOpenGallery(_ title: String? = nil, completion: completion?) -> Self {
        let galleryAction = UIAlertAction(title: title ?? "Gallery", style: .default) { UIAlertAction in
            self.openGallery()
        }
        alert.addAction(galleryAction)
        return self
    }
    
    
//  MARK: - Title
    public func show() {
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        self.alert = UIAlertController(title: "Choose source", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        imagePicker.delegate = self
    }
    
    private func openCamera() {
        imagePicker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            viewController.present(imagePicker, animated: true, completion: nil)
            return
        }
    }
    
    private func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            viewController.present(imagePicker, animated: true, completion: nil)
            return
        }
    }
    
}

//  MARK: - EXTENSION UIImagePickerControllerDelegate
extension ProfileChooseSourceBuilder: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController,  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        profilePicture.placeHolderImage.setContentMode(.scaleAspectFit)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        profilePicture.placeHolderImage.get.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
