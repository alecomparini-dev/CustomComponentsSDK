//
//  Label_Preview.swift
//  CustomComponents
//
//  Created by Alessandro Comparini on 29/08/23.
//

import UIKit
import SwiftUI

final class ButtonBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var buttonPrimary: ButtonBuilder = {
        let btn = ButtonBuilder("Button Primary")
            .setTitleColor("#FFFFFF")
            .setBackgroundColor(hexColor: "#4682A9")
            .setTitleSize(24)
            .setTitleWeight(.regular)
            .setFontFamily("Roboto", 24)
        return btn
    }()
    
    lazy var buttonCustomize: ButtonBuilder = {
        let btn = ButtonBuilder("Button Customize")
            .setTitleColor("#FFFFFF")
            .setBackgroundColor(color: "blue")
            .setBackgroundColor(hexColor: "#007bfc")
            .setTitleSize(20)
            .setTitleWeight(.semibold)
            .setBorder { build in
                build
                    .setCornerRadius(15)
            }
        return btn
    }()
    
    private func configure() {
        backgroundColor = .red
        
        addSubview(buttonPrimary.button)
        addSubview(buttonCustomize.button)
        
        NSLayoutConstraint.activate([
            buttonPrimary.button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonPrimary.button.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonPrimary.button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            buttonPrimary.button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            buttonPrimary.button.heightAnchor.constraint(equalToConstant: 55),
            
            
            buttonCustomize.button.topAnchor.constraint(equalTo: buttonPrimary.button.bottomAnchor, constant: 10),
            buttonCustomize.button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            buttonCustomize.button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            buttonCustomize.button.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
    
}


#if DEBUG
struct ButtonBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        ButtonBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 400)
        .padding(15)
    }
}
#endif
