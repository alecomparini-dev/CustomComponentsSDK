//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit
import SwiftUI

final class TabBarBuilderPreview: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var tabBar: TabBarBuilder = {
        let img = TabBarBuilder()
        let component = TabBarBuilder()
        
        return component
    }()
    
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        backgroundColor = .red
        
    }
    
}



//  MARK: - PREVIEW AREA

#if DEBUG
struct TabBarBuilder_SwiftUI: PreviewProvider {
    static var previews: some View {
        TabBarBuilderPreview()
        .asSwiftUIView
        .frame(width: 400, height: 400)
        .padding(15)
    }
}
#endif
