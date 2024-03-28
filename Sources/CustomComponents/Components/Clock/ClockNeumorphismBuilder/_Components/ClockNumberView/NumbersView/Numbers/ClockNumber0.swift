//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber0: ClockNumberProtocol {

    private let clockNumberBase: ClockNumberBaseView
    
    init(_ clockNumberBase: ClockNumberBaseView) {
        self.clockNumberBase = clockNumberBase
    }
    
    func configure() {
        clockNumberBase.leftTopStroke.setHidden(false)
        clockNumberBase.leftBottomStroke.setHidden(false)
        clockNumberBase.middleTopStroke.setHidden(false)
        clockNumberBase.middleMiddleStroke.setHidden(true)
        clockNumberBase.middleBottomStroke.setHidden(false)
        clockNumberBase.rightTopStroke.setHidden(false)
        clockNumberBase.rightBottomStroke.setHidden(false)
    }

}
