//  Created by Alessandro Comparini on 18/02/24.
//

import Foundation

@MainActor
class ClockNumber {
    
    private let clockNumberBase: ClockNumberBaseView!
    
    init(strokeModel: StrokeModel = StrokeModel()) {
        self.clockNumberBase = ClockNumberBaseView(strokeModel: strokeModel)
    }

    
//  MARK: - PUBLIC AREA
    
    var get: ClockNumberBaseView { clockNumberBase }

    func set(number: Int) {
        switch number {
            case 0:
                ClockNumber0(self.clockNumberBase).configure()
                
            case 1:
                ClockNumber1(self.clockNumberBase).configure()

            case 2:
                ClockNumber2(self.clockNumberBase).configure()

            case 3:
                ClockNumber3(self.clockNumberBase).configure()

            case 4:
                ClockNumber4(self.clockNumberBase).configure()

            case 5:
                ClockNumber5(self.clockNumberBase).configure()

            case 6:
                ClockNumber6(self.clockNumberBase).configure()

            case 7:
                ClockNumber7(self.clockNumberBase).configure()

            case 8:
                ClockNumber8(self.clockNumberBase).configure()

            case 9:
                ClockNumber9(self.clockNumberBase).configure()

        default:
            break
        }

    }

    
}















