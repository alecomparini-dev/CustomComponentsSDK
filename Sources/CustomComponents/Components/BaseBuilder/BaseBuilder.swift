//  Created by Alessandro Comparini on 02/09/23.
//

import UIKit

@MainActor
open class BaseBuilder: NSObject {
    
    private(set) var constraintsFlow: StartOfConstraintsFlow?
    private(set) var autoLayout: StartAutoLayout?
    private var _skeleton: SkeletonBuilder?
    private var _neumorphism: NeumorphismBuilder?
    private var shadow: ShadowBuilder?
    
    private var _id: String = ""
    private weak var _baseView: UIView?
    
    
    public var baseView: UIView {
        get { self._baseView ?? UIView() }
        set { self._baseView = newValue }
    }

    public init(_ view: UIView) {
        self._baseView = view
        super.init()
    }
    
    deinit {
//        baseView.gestureRecognizers?.forEach({ gesture in
//            baseView.removeGestureRecognizer(gesture)
//        })
        constraintsFlow = nil
        autoLayout = nil
        _skeleton = nil
        shadow = nil
        _neumorphism = nil
    }
    
    
//  MARK: - GET PROPERTIES
    public var getTag: Int { baseView.tag  }
    
    public var id: String { _id }
    
    public var skeleton: SkeletonBuilder? { _skeleton }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setID(_ id: String) -> Self {
        _id = id
        return self
    }
    
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
    public func setBackgroundColor(_ color: UIColor?) -> Self {
        guard let color else {return self}
        baseView.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(hexColor: String?) -> Self {
        guard let hexColor, hexColor.isHexColor() else {return self}
        setBackgroundColor(UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(named: String?) -> Self {
        guard let named, let namedColor = UIColor(named: named) else {return self}
        setBackgroundColor(namedColor)
        return self
    }
    
    @discardableResult
    public func setBackgroundColorLayer(_ color: UIColor) -> Self {
        let layer = CAShapeLayer()
        layer.fillColor = color.cgColor
        layer.backgroundColor = color.cgColor
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            let position = UInt32(self.baseView.countShadows().shadowLayer)
            self.baseView.layer.insertSublayer(layer, at: position )
            layer.path = self.baseView.replicateFormat().cgPath
        }
        return self
    }
    
    @discardableResult
    public func setIsUserInteractionEnabled(_ interactionEnabled: Bool?) -> Self {
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
   
    @MainActor @discardableResult
    public func setHidden(_ hide: Bool, animated: Bool = false, _ duration: TimeInterval = 0.3) -> Self {
        if !animated {
            baseView.isHidden = hide
            return self
        }
        animatedHidden(hide, duration)
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
    public func setOverrideUserInterfaceStyle(_ style: UIUserInterfaceStyle) -> Self {
        baseView.overrideUserInterfaceStyle = style
        return self
    }
    
    @discardableResult
    public func setBorder(_ build: (_ build: BorderBuilder) -> BorderBuilder) -> Self {
        _ = build(BorderBuilder(baseView))
        return self
    }

    @discardableResult
    public func setSkeleton(_ build: (_ build: SkeletonBuilder) -> SkeletonBuilder) -> Self {
        _skeleton = build(SkeletonBuilder(component: self))
        return self
    }

    
//  MARK: - SHADOW
    @discardableResult
    public func setShadow(_ build: (_ build: ShadowBuilder) -> ShadowBuilder) -> Self {
        _ = build(ShadowBuilder(baseView))
        return self
    }

    
//  MARK: - GRADIENT
    @discardableResult
    public func setGradient(_ build: (_ build: GradientBuilder) -> GradientBuilder) -> Self {
        _ = build(GradientBuilder(baseView))
        return self
    }
    
    
//  MARK: - NEUMORPHISM
    @discardableResult
    public func setNeumorphism(_ build: (_ build: NeumorphismBuilder) -> NeumorphismBuilder) -> Self {
        _ = build(NeumorphismBuilder(baseView))
        return self
    }
        
    
//  MARK: - SET ACTIONS
    @discardableResult
    public func setActions(_ build: (_ build: ActionBuilder) -> ActionBuilder) -> Self {
        _ = build(ActionBuilder( component: baseView))
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
    

//  MARK: - AUTO LAYOUT AREA
    @discardableResult
    public func setAutoLayout(_ build: (_ build: StartAutoLayout) -> StartAutoLayout) -> Self {
        self.autoLayout = build(StartAutoLayout(element: baseView))
        return self
    }
    
    @discardableResult
    public func applyAutoLayout() -> Self {
        self.autoLayout?.apply()
        autoLayout = nil
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
    
    public func add(insideTo element: BaseBuilder) {
        add(insideTo: element.baseView)
    }
    
//  MARK: - PRIVATE AREA
    private func animatedHidden(_ hide: Bool, _ duration: TimeInterval) {
        if hide {
            baseView.alpha = 1
            baseView.isHidden = false
            UIView.animate(withDuration: duration, delay: 0, animations: { [weak self] in
                guard let self else {return}
                baseView.alpha = 0
            }) { [weak self] bool in
                guard let self else {return}
                if bool {
                    baseView.isHidden = hide
                }
            }
            return
        }
        
        baseView.alpha = 0
        baseView.isHidden = false
        UIView.animate(withDuration: duration, delay: 0, animations: { [weak self] in
            guard let self else {return}
            baseView.alpha = 1
        }) { [weak self] bool in
            guard let self else {return}
            if bool {
                baseView.isHidden = hide
            }
        }
        
    }
    
}

