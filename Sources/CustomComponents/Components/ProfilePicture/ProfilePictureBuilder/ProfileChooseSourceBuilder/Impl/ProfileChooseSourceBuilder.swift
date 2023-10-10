//  Created by Alessandro Comparini on 10/10/23.
//

import UIKit

public class ProfileChooseSourceBuilder: ProfileChooseSource {
    
    private var alert: UIAlertController!
    private let imagePicker = UIImagePickerController()
    
    private var viewController: UIViewController
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
        configure()
    }
    

//  MARK: - SET PROPERTIES
    @discardableResult
    public func setTitle(title: String) -> Self {
        alert.title = title
        return self
    }
    
    @discardableResult
    public func setOpenCamera(completion: completion?) -> Self {
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.openCamera()
        }
        alert.addAction(cameraAction)
        return self
    }
    
    @discardableResult
    public func setOpenGallery(completion: completion?) -> Self {
        return self
    }
    
    
//  MARK: - Title
    public func show() {
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        self.alert = UIAlertController(title: "Choose source", message:"", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
    }
    
    private func openCamera() {
        self.imagePicker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            viewController.present(imagePicker, animated: true, completion: nil)
            return
        }
    }
}
