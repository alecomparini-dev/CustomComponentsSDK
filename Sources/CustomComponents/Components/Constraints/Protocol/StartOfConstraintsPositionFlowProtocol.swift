//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

public protocol StartOfConstraintsPositionFlowProtocol {
    associatedtype T
    var setTop: EndOfConstraintsPositionFlowProtocol { get }
    var setBottom: EndOfConstraintsPositionFlowProtocol { get }
    var setLeading: EndOfConstraintsPositionFlowProtocol { get }
    var setTrailing: EndOfConstraintsPositionFlowProtocol { get }
    var setWidth: EndOfConstraintsPositionFlowProtocol { get }
    var setHeight: EndOfConstraintsPositionFlowProtocol { get }
   
    func equalTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow
    func equalTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow
    func lessThanOrEqualTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow
    func lessThanOrEqualTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow
    func greaterThanOrEqualTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow
    func greaterThanOrEqualTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow
    
    var equalToSafeArea: StartOfConstraintsFlow { get }
    func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    var lessThanOrEqualToSafeArea: StartOfConstraintsFlow { get }
    func lessThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    var greaterThanOrEqualToSafeArea: StartOfConstraintsFlow { get }
    func greaterThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    
    var equalToSuperview: StartOfConstraintsFlow { get }
    func equalToSuperview(_ constant: CGFloat) -> StartOfConstraintsFlow
    var lessThanOrEqualToSuperview: StartOfConstraintsFlow { get }
    func lessThanOrEqualToSuperview(_ constant: CGFloat) -> StartOfConstraintsFlow
    var greaterThanOrEqualToSuperview: StartOfConstraintsFlow { get }
    func greaterThanOrEqualToSuperview(_ constant: CGFloat) -> StartOfConstraintsFlow
    
}
