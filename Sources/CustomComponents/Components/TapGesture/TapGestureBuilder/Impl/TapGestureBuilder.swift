//  Created by Alessandro Comparini on 12/09/23.
//

import UIKit

public class TapGestureBuilder: UITapGestureRecognizer, TapGesture {
    
    public enum GestureRelativeTo {
        case window
        case superview
        case component
    }
    
    private var _touchPositionComponent: CGPoint = CGPointZero
    private var _touchPositionSuperView: CGPoint = CGPointZero
    private var _touchPositionWindow: CGPoint = CGPointZero
    
    private var tap: [touchGestureAlias] = []
    private var touchMoved: [touchGestureAlias] = []
    private var touchCancelled: [touchGestureAlias] = []
    
    private weak var component: BaseBuilder?
    
    public init(_ component: BaseBuilder ) {
        self.component = component
        super.init(target: nil, action: nil)
        self.initialization()
    }
    
    private func initialization() {
        enableUserInteractionComponent()
        addTargetOnComponent()
    }
    
    
//  MARK: - GET PROPERTIES
    
    public func getTouchPosition(_ touchPositionRelative: GestureRelativeTo) -> CGPoint {
        switch touchPositionRelative {
            case .window:
                return _touchPositionWindow
            case .superview:
                return _touchPositionSuperView
            case .component:
                return _touchPositionComponent
        }
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setNumberOfTapsRequired(_ numberOfTaps: Int) -> Self {
        self.numberOfTapsRequired = numberOfTaps
        return self
    }
    
    @discardableResult
    public func setNumberOfTouchesRequired(_ numberOfTouches: Int) -> Self {
        self.numberOfTouchesRequired = numberOfTouches
        return self
    }
    
    @discardableResult
    public func setCancelsTouchesInView(_ cancel: Bool) -> Self {
        self.cancelsTouchesInView = cancel
        return self
    }
    
    @discardableResult
    public func setTap(_ closure: @escaping touchGestureAlias) -> Self {
        tap.append(closure)
        return self
    }
    
    @discardableResult
    public func setTouchMoved(_ closure: @escaping touchGestureAlias) -> Self {
        touchMoved.append(closure)
        return self
    }
    
    @discardableResult
    public func setTouchCancelled(_ closure: @escaping touchGestureAlias) -> Self {
        touchCancelled.append(closure)
        return self
    }
    
    @discardableResult
    public func setIsEnabled(_ enabled: Bool) -> Self {
        self.isEnabled = enabled
        return self
    }
    
    public func removeTapGesture() {
        component?.baseView.removeGestureRecognizer(self)
    }
    
    
//  MARK: - PRIVATE AREA
    private func enableUserInteractionComponent() {
        component?.baseView.isUserInteractionEnabled = true
    }
    
    private func addTargetOnComponent() {
        self.addTarget(self, action: #selector(objcTapGesture))
        component?.baseView.addGestureRecognizer(self)
    }
    
    private func performTap(_ completion: [touchGestureAlias]) {
        setTouchPositions()
        completion.forEach({ [weak self] closure in
            guard let self else {return}
            closure(self)
        })
    }
    
    private func setTouchPositions() {
        _touchPositionWindow = self.location(in: nil)
        _touchPositionSuperView = self.location(in: component?.baseView.superview)
        _touchPositionComponent = self.location(in: component?.baseView)
    }
    
    
//  MARK: - @OBJC GESTURE
    @objc private func objcTapGesture(_ gesture: UITapGestureRecognizer) {
        
        switch gesture.state {
            case .ended:
                performTap(tap)
            case .changed:
                performTap(touchMoved)
            case .cancelled:
                performTap(touchCancelled)
            default:
                break
        }
    }
    
}


//  MARK: - EXTENSION - UIGestureRecognizerDelegate
extension TapGestureBuilder: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.cancelsTouchesInView
    }
}
