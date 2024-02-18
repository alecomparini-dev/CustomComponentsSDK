//  Created by Alessandro Comparini on 18/02/24.
//

import Foundation

class FacadeClockNumber {
    
    private let clockNumberBase: ClockNumberBaseView!
    
    init(strokeModel: StrokeModel = StrokeModel()) {
        self.clockNumberBase = ClockNumberBaseView(strokeModel: strokeModel)
    }

    
//  MARK: - PUBLIC AREA
    
    func create(number: Int) -> ClockNumberView {
        switch number {
            case 0:
            return ClockNumber0(self.clockNumberBase).configure()
                
            case 1:
                return ClockNumber1(self.clockNumberBase).configure()

            case 2:
                return ClockNumber2(self.clockNumberBase).configure()
//
            case 3:
                return ClockNumber3(self.clockNumberBase).configure()
//
//            case 4:
//                return ClockNumber4View(strokeModel: strokeModel)
//
//            case 5:
//                return ClockNumber5View(strokeModel: strokeModel)
//
//            case 6:
//                return ClockNumber6View(strokeModel: strokeModel)
//
//            case 7:
//                return ClockNumber7View(strokeModel: strokeModel)
//
//            case 8:
//                return ClockNumberBaseView(strokeModel: strokeModel)
//
//            case 9:
//                return ClockNumber9View(strokeModel: strokeModel)

        default:
            return ClockNumberView()
        }
        
    }
    
    
}


protocol ClockNumber {
    func configure() -> ClockNumberBaseView
}

class ClockNumber0: ClockNumber {

    private let clockNumberBase: ClockNumberBaseView
    
    init(_ clockNumberBase: ClockNumberBaseView) {
        self.clockNumberBase = clockNumberBase
    }
    
    func configure() -> ClockNumberBaseView {
        clockNumberBase.leftTopStroke.setHidden(false)
        clockNumberBase.leftBottomStroke.setHidden(false)
        clockNumberBase.middleTopStroke.setHidden(false)
        clockNumberBase.middleMiddleStroke.setHidden(true)
        clockNumberBase.middleBottomStroke.setHidden(false)
        clockNumberBase.rightTopStroke.setHidden(false)
        clockNumberBase.rightBottomStroke.setHidden(false)
        return clockNumberBase
    }

}

class ClockNumber1: ClockNumber {

    private let clockNumberBase: ClockNumberBaseView
    
    init(_ clockNumberBase: ClockNumberBaseView) {
        self.clockNumberBase = clockNumberBase
    }
    
    func configure() -> ClockNumberBaseView {
        clockNumberBase.leftTopStroke.setHidden(false)
        clockNumberBase.leftBottomStroke.setHidden(false)
        clockNumberBase.middleTopStroke.setHidden(false)
        clockNumberBase.middleMiddleStroke.setHidden(true)
        clockNumberBase.middleBottomStroke.setHidden(false)
        clockNumberBase.rightTopStroke.setHidden(false)
        clockNumberBase.rightBottomStroke.setHidden(false)
        return clockNumberBase
    }

}

class ClockNumber2: ClockNumber {

    private let clockNumberBase: ClockNumberBaseView
    
    init(_ clockNumberBase: ClockNumberBaseView) {
        self.clockNumberBase = clockNumberBase
    }
    
    func configure() -> ClockNumberBaseView {
        clockNumberBase.leftTopStroke.setHidden(false)
        clockNumberBase.leftBottomStroke.setHidden(true)
        clockNumberBase.middleTopStroke.setHidden(false)
        clockNumberBase.middleMiddleStroke.setHidden(false)
        clockNumberBase.middleBottomStroke.setHidden(false)
        clockNumberBase.rightTopStroke.setHidden(true)
        clockNumberBase.rightBottomStroke.setHidden(false)
        return clockNumberBase
    }

}

class ClockNumber3: ClockNumber {

    private let clockNumberBase: ClockNumberBaseView
    
    init(_ clockNumberBase: ClockNumberBaseView) {
        self.clockNumberBase = clockNumberBase
    }
    
    func configure() -> ClockNumberBaseView {
        clockNumberBase.leftTopStroke.setHidden(true)
        clockNumberBase.leftBottomStroke.setHidden(true)
        clockNumberBase.middleTopStroke.setHidden(false)
        clockNumberBase.middleMiddleStroke.setHidden(false)
        clockNumberBase.middleBottomStroke.setHidden(false)
        clockNumberBase.rightTopStroke.setHidden(false)
        clockNumberBase.rightBottomStroke.setHidden(false)
        return clockNumberBase
    }

}
