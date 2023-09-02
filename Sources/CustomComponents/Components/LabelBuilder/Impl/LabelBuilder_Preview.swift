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
            .setColor("#FFFFFF")
            .setWeight(.thin)
            .setSize(50)
        return label
    }()
    
    private func configure() {
        backgroundColor = .red
        
        addSubview(label.label)
        
        print(label.label)
        
        NSLayoutConstraint.activate([
            label.label.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            label.label.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ])
        
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
