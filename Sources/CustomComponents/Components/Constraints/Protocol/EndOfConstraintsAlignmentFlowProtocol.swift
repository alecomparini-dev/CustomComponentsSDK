
//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

protocol EndOfConstraintsAlignmentFlowProtocol {
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    var equalToSafeArea: StartOfConstraintsFlow { get }
    var equalToSuperView: StartOfConstraintsFlow { get }
}
