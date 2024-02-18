//  Created by Alessandro Comparini on 18/02/24.
//

import Foundation

class FacadeClockNumber {
    
    private let strokeModel: StrokeModel
    
    init(strokeModel: StrokeModel = StrokeModel()) {
        self.strokeModel = strokeModel
    }

    
//  MARK: - PUBLIC AREA
    
    public func create(number: Int) -> ClockNumberView {
        switch number {
            case 0:
                return ClockNumber0View(strokeModel: strokeModel)
                
            case 1:
                return ClockNumber1View(strokeModel: strokeModel)

            case 2:
                return ClockNumber2View(strokeModel: strokeModel)

            case 3:
                return ClockNumber3View(strokeModel: strokeModel)

            case 4:
                return ClockNumber4View(strokeModel: strokeModel)

            case 5:
                return ClockNumber5View(strokeModel: strokeModel)

            case 6:
                return ClockNumber6View(strokeModel: strokeModel)

            case 7:
                return ClockNumber7View(strokeModel: strokeModel)

            case 8:
                return ClockNumberBaseView(strokeModel: strokeModel)

            case 9:
                return ClockNumber9View(strokeModel: strokeModel)

        default:
            return ClockNumberView()
        }
        
        
    }
    
    
    
}
