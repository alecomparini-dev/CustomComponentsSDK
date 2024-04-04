//  Created by Alessandro Comparini on 04/04/24.
//

import UIKit

public class OverlayView: BlurBuilder {
    
    public init() {
        super.init(style: .systemUltraThinMaterialDark)
        configure()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        self.setOpacity(0.98)
    }
    
}
