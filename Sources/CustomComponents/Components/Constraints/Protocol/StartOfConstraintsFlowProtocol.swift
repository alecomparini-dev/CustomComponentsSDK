//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

public protocol StartOfConstraintsFlowProtocol {
    var setTop: StartOfConstraintsPositionFlow<ConstraintsPositionY> { get }
    var setBottom: StartOfConstraintsPositionFlow<ConstraintsPositionY> { get }
    
    var setLeading: StartOfConstraintsPositionFlow<ConstraintsPositionX> { get }
    var setTrailing: StartOfConstraintsPositionFlow<ConstraintsPositionX> { get }
    
    var setWidth: StartOfConstraintsSizeFlowProtocol { get }
    var setHeight: StartOfConstraintsSizeFlowProtocol { get }
    
    var setHorizontalAlignmentX: StartOfConstraintsAlignmentFlowProtocol { get }
    var setVerticalAlignmentY: StartOfConstraintsAlignmentFlowProtocol { get }
}
