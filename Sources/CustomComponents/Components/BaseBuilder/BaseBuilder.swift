//  Created by Alessandro Comparini on 02/09/23.
//

import UIKit

open class BaseBuilder: NSObject {
    
    private(set) var constraintsFlow: StartOfConstraintsFlow?
    private weak var border: BorderBuilder?
    private var _shadow: ShadowBuilder?
    private var _gradient: GradientBuilder?
    private var _skeleton: SkeletonBuilder?
    
    private weak var _baseView: UIView?
    
    var baseView: UIView {
        get { self._baseView ?? UIView() }
        set { self._baseView = newValue }
    }

    public init(_ view: UIView) {
        self._baseView = view
        super.init()
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    
    
//  MARK: - GET PROPERTIES
    public var getTag: Int { baseView.tag  }
    
    public var skeleton: SkeletonBuilder? {
        get { _skeleton }
        set { _skeleton = newValue}
    }
    
    public var gradient: GradientBuilder? {
        get { _gradient }
        set { _gradient = newValue}
    }
    
    public var shadow: ShadowBuilder? {
        get { _shadow }
        set { _shadow = newValue}
    }

    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setTranslatesAutoresizingMaskIntoConstraints(_ flag: Bool) -> Self {
        baseView.translatesAutoresizingMaskIntoConstraints = flag
        return self
    }
    
    @discardableResult
    public func setFrame(_ frame: CGRect?) -> Self {
        guard let frame else {return self}
        baseView.frame = frame
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(color: UIColor?) -> Self {
        guard let color else {return self}
        baseView.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(hexColor: String?) -> Self {
        guard let hexColor, hexColor.isHexColor() else {return self}
        setBackgroundColor(color: UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(named: String?) -> Self {
        guard let named, let namedColor = UIColor(named: named) else {return self}
        setBackgroundColor(color: namedColor)
        return self
    }
    
    @discardableResult
    func setIsUserInteractionEnabled(_ interactionEnabled: Bool?) -> Self {
        guard let interactionEnabled else {return self}
        baseView.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    public func setOpacity(_ opacity: Float?) -> Self {
        guard let opacity else {return self}
        baseView.layer.opacity = opacity
        return self
    }
    
    @discardableResult
    public func setAlpha(_ alpha: CGFloat?) -> Self {
        guard let alpha else {return self}
        baseView.alpha = alpha
        return self
    }
   
    @discardableResult
    public func setHidden(_ hide: Bool?) -> Self {
        guard let hide else {return self}
        baseView.isHidden = hide
        return self
    }
    
    @discardableResult
    public func setShimmer(_ build: (_ build: ShimmerBuilder) -> ShimmerBuilder) -> Self {
        _ = build(ShimmerBuilder(component: baseView))
        return self
    }
    
    @discardableResult
    public func setTag(_ tag: Int) -> Self {
        baseView.tag = tag
        return self
    }
    
    @discardableResult
    public func setBorder(_ build: (_ build: BorderBuilder) -> BorderBuilder) -> Self {
        border = build(BorderBuilder(baseView))
        return self
    }

    @discardableResult
    public func setShadow(_ build: (_ build: ShadowBuilder) -> ShadowBuilder) -> Self {
        shadow = build(ShadowBuilder(self))
        return self
    }
    
    @discardableResult
    public func setSkeleton(_ build: (_ build: SkeletonBuilder) -> SkeletonBuilder) -> Self {
        skeleton = build(SkeletonBuilder(component: self))
        return self
    }
    
    @discardableResult
    public func setGradient(_ build: (_ build: GradientBuilder) -> GradientBuilder) -> Self {
        _ = build(GradientBuilder(baseView))
        return self
    }
    
    @discardableResult
    public func setNeumorphism(_ build: (_ build: NeumorphismBuilder) -> NeumorphismBuilder) -> Self {
        _ = build(NeumorphismBuilder(self))
        return self
    }

    
//  MARK: - CONSTRAINTS AREA
    
    @discardableResult
    public func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintsFlow = builderConstraint(StartOfConstraintsFlow(baseView))
        return self
    }
    
    @discardableResult
    public func applyConstraint() -> Self {
        self.constraintsFlow?.apply()
        constraintsFlow = nil
        return self
    }

    public func add(insideTo element: UIView) {
        if element.isKind(of: UIStackView.self) {
            let element = element as! UIStackView
            element.addArrangedSubview(baseView)
            return
        }
        element.addSubview(baseView)
    }
    
}

