//  Created by Alessandro Comparini on 10/10/23.
//

import UIKit

@MainActor
open class ProfileChooseSourceBuilder: NSObject, ProfileChooseSource {
    private struct Control {
        static var isOpenCamera = false
    }
    
    private var completionOpenCamera: ProfileChooseSource.completion?
    private var completionOpenGallery: ProfileChooseSource.completion?
    
    private var alert: UIAlertController?
//    private var imagePicker: UIImagePickerController?
    private lazy var imagePicker = UIImagePickerController()
    
    private weak var viewController: UIViewController?
    private weak var profilePicture: ProfilePictureBuilder?
    

    
    public init(viewController: UIViewController, profilePicture: ProfilePictureBuilder) {
        self.viewController = viewController
        self.profilePicture = profilePicture
        super.init()
        configure()
    }
    

//  MARK: - SET PROPERTIES
    @discardableResult
    public func setTitle(_ title: String) -> Self {
        alert?.title = title
        return self
    }
    
    @discardableResult
    public func setOpenCamera(_ title: String? = nil, completion: completion?) -> Self {
        let cameraAction = UIAlertAction(title: title ?? "Camera", style: .default) { [weak self] _ in
            self?.openCamera()
            self?.completionOpenCamera = completion
            Control.isOpenCamera = true
        }
        alert?.addAction(cameraAction)
        return self
    }
    
    @discardableResult
    public func setOpenGallery(_ title: String? = nil, completion: completion?) -> Self {
        let galleryAction = UIAlertAction(title: title ?? "Gallery", style: .default) { [weak self] _ in
            self?.openGallery()
            self?.completionOpenGallery = completion
            Control.isOpenCamera = false
        }
        alert?.addAction(galleryAction)
        return self
    }
    

//  MARK: - SHOW ALERT
    public func show() {
        if let alert {
            viewController?.present(alert, animated: true, completion: nil)
        }
    }

    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            guard let self else {return}
            imagePicker.delegate = self
        })
        alert = UIAlertController(title: "Choose source", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert?.addAction(cancelAction)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            viewController?.present(imagePicker, animated: true, completion: nil)
            return
        }
    }
    
    private func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            viewController?.present(imagePicker, animated: true, completion: nil)
            return
        }
    }
    
    private func resetControl() {
        Control.isOpenCamera = false
    }
    
    private func callCompletion(_ image: UIImage) {
        let imgViewBuilder = ImageViewBuilder()
        imgViewBuilder.get.image = image

        if Control.isOpenCamera {
            if let completionOpenCamera {
                completionOpenCamera(imgViewBuilder)
            }
            return
        }
        
        if let completionOpenGallery {
            completionOpenGallery(imgViewBuilder)
        }
    }
    
}

//  MARK: - EXTENSION UIImagePickerControllerDelegate
extension ProfileChooseSourceBuilder: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController,  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                
        guard let image = info[.originalImage] as? UIImage else { return }
        
        profilePicture?.setImagePicture(image)
        
        picker.dismiss(animated: true, completion: nil)
        
        callCompletion(image)
        
        resetControl()
    }
    
}
