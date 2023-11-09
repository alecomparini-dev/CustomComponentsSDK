//  Created by Alessandro Comparini on 08/11/23.
//

import UIKit
import SwiftUI

final class SkeletonBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    lazy var textField: TextFieldBuilder = {
        let component = TextFieldBuilder("Place Holder")
            .setText("Teste do Skeleton")
            .setBackgroundColor(hexColor: "#ffffff")
            .setBorder { build in
                build
                    .setCornerRadius(8)
            }
            .setSkeleton({ build in
                build
                    .setColorSkeleton(color: .yellow)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(20)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(45)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return component
    }()
    
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        backgroundColor = .red
        addSubview(textField.get)
        textField.applyConstraint()
    }
    
}



//  MARK: - PREVIEW AREA

#if DEBUG
struct SkeletonBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        SkeletonBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 400)
        .padding(15)
    }
}
#endif
