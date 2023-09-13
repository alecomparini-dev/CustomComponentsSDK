//
//  Label_Preview.swift
//  CustomComponents
//
//  Created by Alessandro Comparini on 29/08/23.
//

import UIKit
import SwiftUI

final class LabelBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: LabelBuilder = {
        let label = LabelBuilder("Teste Label Builder")
            .setColor(hexColor: "#FFFFFF")
            .setWeight(.thin)
            .setSize(50)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSafeArea
            }
        return label
    }()
    
    private func configure() {
        backgroundColor = .red       
        addSubview(label.get)
        label.applyConstraint()
                
    }
    
}


#if DEBUG
struct LabelBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        LabelBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 200)
        .padding(15)
    }
}
#endif
