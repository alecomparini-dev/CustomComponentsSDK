
//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

protocol EndOfConstraintsSizeFlowProtocol  {
    var setTop: EndOfConstraintsSizeFlowProtocol { get }
    var setBottom: EndOfConstraintsSizeFlowProtocol { get }
    var setLeading: EndOfConstraintsSizeFlowProtocol { get }
    var setTrailing: EndOfConstraintsSizeFlowProtocol { get }
    var setWidth:  EndOfConstraintsSizeFlowProtocol { get }
    var setHeight:  EndOfConstraintsSizeFlowProtocol { get }
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    var equalToSafeArea: StartOfConstraintsFlow { get }
    var equalToSuperView: StartOfConstraintsFlow { get }
}
