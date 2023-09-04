//
//  File.swift
//  
//
//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

public protocol StartOfConstraintsAlignmentFlowProtocol {
    var setHorizontalAlignmentX: EndOfConstraintsAlignmentFlowProtocol { get }
    var setVerticalAlignmentY: EndOfConstraintsAlignmentFlowProtocol { get }
    func equalTo(_ element: UIView, _ constant: CGFloat) -> StartOfConstraintsFlow
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    var equalToSafeArea: StartOfConstraintsFlow { get }
    func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    var equalToSuperView: StartOfConstraintsFlow { get }
    func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow
}
