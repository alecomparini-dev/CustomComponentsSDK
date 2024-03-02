
//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

public protocol EndOfConstraintsAlignmentFlowProtocol {
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    var equalToSafeArea: StartOfConstraintsFlow { get }
    var equalToSuperview: StartOfConstraintsFlow { get }
}
