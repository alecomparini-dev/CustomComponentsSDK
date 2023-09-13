//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit
import SwiftUI

final class SwitchBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//  MARK: - LAZY AREA
    lazy var switchView: SwitchBuilder = {
        let component = SwitchBuilder()
            .setThumbTintColor(hexColor: "#335522")
            .setOnTintColor(hexColor: "#000000")
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSafeArea
                    .setWidth.equalToConstant(50)
                    .setHeight.equalToConstant(30)
            }
        return component
    }()
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        backgroundColor = .red
        
        addSubview(switchView.get)
        switchView.applyConstraint()
        
    }
    
}



//  MARK: - PREVIEW AREA

#if DEBUG
struct SwitchBuilderPreview_SwiftUI: PreviewProvider {
    static var previews: some View {
        SwitchBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 400)
        .padding(15)
    }
}
#endif
