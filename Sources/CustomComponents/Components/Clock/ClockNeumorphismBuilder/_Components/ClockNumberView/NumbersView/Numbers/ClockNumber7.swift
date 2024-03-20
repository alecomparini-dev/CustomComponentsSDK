//  Created by Alessandro Comparini on 16/02/24.
//

import Foundation

class ClockNumber7: ClockNumberProtocol {

    private let clockNumberBase: ClockNumberBaseView
    
    init(_ clockNumberBase: ClockNumberBaseView) {
        self.clockNumberBase = clockNumberBase
    }
    
    func configure() {
        clockNumberBase.leftTopStroke.setHidden(true)
        clockNumberBase.leftBottomStroke.setHidden(true)
        clockNumberBase.middleTopStroke.setHidden(false)
        clockNumberBase.middleMiddleStroke.setHidden(true)
        clockNumberBase.middleBottomStroke.setHidden(true)
        clockNumberBase.rightTopStroke.setHidden(false)
        clockNumberBase.rightBottomStroke.setHidden(false)
    }

}
