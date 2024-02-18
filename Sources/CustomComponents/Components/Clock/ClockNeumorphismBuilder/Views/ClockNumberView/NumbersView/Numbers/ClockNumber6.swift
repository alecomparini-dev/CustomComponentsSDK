//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber6: ClockNumberProtocol {

    private let clockNumberBase: ClockNumberBaseView
    
    init(_ clockNumberBase: ClockNumberBaseView) {
        self.clockNumberBase = clockNumberBase
    }
    
    func configure() {
        clockNumberBase.leftTopStroke.setHidden(false)
        clockNumberBase.leftBottomStroke.setHidden(false)
        clockNumberBase.middleTopStroke.setHidden(true)
        clockNumberBase.middleMiddleStroke.setHidden(false)
        clockNumberBase.middleBottomStroke.setHidden(false)
        clockNumberBase.rightTopStroke.setHidden(true)
        clockNumberBase.rightBottomStroke.setHidden(false)
    }

}
