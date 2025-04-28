//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit
import SwiftUI

final class TextViewBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    lazy var textView: TextViewBuilder = {
        let component = TextViewBuilder()
            .setBackgroundColor(hexColor: "#ffffff")
            .setInsertText("Rua 29 Quadra 11 Casa 12\n")
            .setInsertText("71909-283\n")
            .setInsertText("Brasília-DF\n")
            .setSize(14)
            .setBorder { build in
                build
                    .setCornerRadius(8)
            }
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(20)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(90)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return component
    }()
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        backgroundColor = .red
        textView.add(insideTo: self)
        textView.applyConstraint()
    }
    
}



//  MARK: - PREVIEW AREA

#if DEBUG
struct TextViewBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        TextViewBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 400)
        .padding(15)
    }
}
#endif
