//
//  File.swift
//  
//
//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

public protocol StartOfConstraintsSizeFlowProtocol {
    var setTop: EndOfConstraintsSizeFlowProtocol { get }
    var setBottom: EndOfConstraintsSizeFlowProtocol { get }
    var setLeading: EndOfConstraintsSizeFlowProtocol { get }
    var setTrailing: EndOfConstraintsSizeFlowProtocol { get }
    var setWidth: StartOfConstraintsSizeFlowProtocol { get }
    var setHeight: StartOfConstraintsSizeFlowProtocol { get }
    
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    func lessThanOrEqualTo(_ element: UIView) -> StartOfConstraintsFlow
    func greaterThanOrEqualTo(_ element: UIView) -> StartOfConstraintsFlow
    
    func equalToConstant(_ constant: CGFloat) -> StartOfConstraintsFlow
    func lessThanOrEqualToConstant(_ constant: CGFloat) -> StartOfConstraintsFlow
    func greaterThanOrEqualToConstant(_ constant: CGFloat) -> StartOfConstraintsFlow
    
    var equalToSafeArea: StartOfConstraintsFlow { get }
    func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    var greaterThanOrEqualToSafeArea: StartOfConstraintsFlow { get }
    func greaterThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    var lessThanOrEqualToSafeArea: StartOfConstraintsFlow { get }
    func lessThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    
    var equalToSuperView: StartOfConstraintsFlow { get }
    func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow
    var greaterThanOrEqualToSuperView: StartOfConstraintsFlow { get }
    func greaterThanOrEqualToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow
    var lessThanOrEqualToSuperView: StartOfConstraintsFlow { get }
    func lessThanOrEqualToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow
}
