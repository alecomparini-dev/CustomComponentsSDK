//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit
import SwiftUI

final class TextFieldBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//  MARK: - LAZY AREA
    lazy var buttonPrimary: TextFieldBuilder = {
        let btn = TextFieldBuilder("Place Holder")
            .setBackgroundColor(hexColor: "#ffffff")
        return btn
    }()
    
    lazy var buttonCustomize: ButtonBuilder = {
        let btn = ButtonBuilder("Button Customize")
            .setTitleColor(hexColor: "#FFFFFF")
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
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        backgroundColor = .red
        
        addSubview(buttonPrimary.get)
        addSubview(buttonCustomize.get)
        
        NSLayoutConstraint.activate([
            buttonPrimary.get.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonPrimary.get.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonPrimary.get.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            buttonPrimary.get.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            buttonPrimary.get.heightAnchor.constraint(equalToConstant: 55),
            
            
            buttonCustomize.get.topAnchor.constraint(equalTo: buttonPrimary.get.bottomAnchor, constant: 10),
            buttonCustomize.get.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            buttonCustomize.get.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            buttonCustomize.get.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
    
}



//  MARK: - PREVIEW AREA

#if DEBUG
struct TextFieldBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        TextFieldBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 400)
        .padding(15)
    }
}
#endif
