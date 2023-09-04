//
//  File.swift
//  
//
//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

public protocol EndOfConstraintsPositionFlowProtocol {
    var setTop: EndOfConstraintsPositionFlowProtocol{ get }
    var setBottom: EndOfConstraintsPositionFlowProtocol{ get }
    var setLeading: EndOfConstraintsPositionFlowProtocol{ get }
    var setTrailing: EndOfConstraintsPositionFlowProtocol{ get }
    var setWidth: EndOfConstraintsSizeFlowProtocol{ get }
    var setHeight: EndOfConstraintsSizeFlowProtocol{ get }
    func equalTo(_ element: UIView, _ constant: CGFloat) -> StartOfConstraintsFlow
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    var equalToSafeArea: StartOfConstraintsFlow { get }
    func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    var equalToSuperView: StartOfConstraintsFlow { get }
    func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow
}
