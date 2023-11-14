//  Created by Alessandro Comparini on 13/11/23.
//

import UIKit

open class StackViewBuilder: StackView {
    public typealias T = UIStackView
    
    public var get: UIStackView { self.stackView }
    
    private let stackView: UIStackView
    
    public init() {
        self.stackView = UIStackView()
    }
    

//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setDistribution(_ distribution: K.StackView.Distribution) -> Self {
        stackView.distribution = UIStackView.Distribution(rawValue: distribution.rawValue) ?? .fillEqually
        return self
    }
    
    @discardableResult
    public func setAxis(_ axis: K.Axis) -> Self {
        stackView.axis = NSLayoutConstraint.Axis(rawValue: axis.rawValue) ?? .horizontal
        return self
    }
    
    @discardableResult
    public func setAlignment(_ alignment: K.StackView.Alignment) -> Self {
        switch alignment {
            case .top:
                stackView.alignment = .top
                
            case .bottom:
                stackView.alignment = .bottom
                
            default:
                stackView.alignment = UIStackView.Alignment(rawValue: alignment.rawValue) ?? .center
        }
        return self
    }
    
    @discardableResult
    public func setSpacing(_ spacing: CGFloat) -> Self {
        stackView.spacing = spacing
        return self
    }
    
    
}
