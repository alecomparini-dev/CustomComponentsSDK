//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit
import SwiftUI


final class ProfilePictureBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var profilePicture: ProfilePictureBuilder = {
        let img = ImageViewBuilder(systemName: "person")
            .setContentMode(.scaleAspectFill)
            .setBackgroundColor(.yellow)
//            .setSize(30)
            .setWeight(.ultraLight)
        let comp = ProfilePictureBuilder(size: 100, image: img )
            .setBackgroundColor(hexColor: "#ffffff")
            .setTintColor("#000000")
            .setChooseSource(viewController: UIViewController(), { build in
                build
                    .setOpenCamera { imageData in 
                        print("camera")
                    }
            })
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
        return comp
    }()
    
    private func configure() {
        backgroundColor = .red
        addSubview(profilePicture.get)
        profilePicture.applyConstraint()
    }
    
}


#if DEBUG
struct ProfilePictureBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        ProfilePictureBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 200)
        .padding(15)
    }
}
#endif
