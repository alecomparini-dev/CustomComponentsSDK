//  Created by Alessandro Comparini on 13/11/23.
//

import Foundation

@MainActor
public protocol StackView {
    associatedtype T
    var get: T { get }
    
    @discardableResult
    func setDistribution(_ distribution: UIK.StackView.Distribution) -> Self

    @discardableResult
    func setAxis(_ axis: UIK.Axis) -> Self

    @discardableResult
    func setAlignment(_ alignment: UIK.StackView.Alignment) -> Self
    
    @discardableResult
    func setSpacing(_ spacing: CGFloat) -> Self
}
