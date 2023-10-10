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
        let img = ImageViewBuilder(systemName: "camera.viewfinder")
            .setContentMode(.center)
            .setSize(40)
            .setWeight(.ultraLight)
//        let comp = ProfilePictureBuilder(size: 100, image: img )
        let comp = ProfilePictureBuilder(size: 100 )
            .setBackgroundColor(hexColor: "#ffffff")
            .setTintColor("#000000")
            .setSizePlaceHolderImage(40)
//            .setCornerRadius(30)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSafeArea
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
