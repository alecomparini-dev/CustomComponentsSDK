//  Created by Alessandro Comparini on 23/05/24.
//

import UIKit

open class ModalViewBuilder: ModalView {
    public typealias S = UIBlurEffect.Style
    
    
    private var isVisible = false
    private var isApplyOnce = false
    private var autoCloseEnabled = false

    private var animationDuration: TimeInterval = 0
    private var zPosition: CGFloat = 10000
    private var overlay: BlurBuilder?

//  MARK: - INITIALIZERS
    
    public var get: ViewBuilder {modal}
    private let modal: ViewBuilder
    
    init() {
        self.modal = ViewBuilder()
    }
    
    
//  MARK: - GET PROPERTIES
    
    public func isShow() -> Bool { isVisible }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setCloseWhenTappedOut() -> Self {
        autoCloseEnabled = true
        return self
    }
    
    @discardableResult
    public func setOverlay(style: UIBlurEffect.Style, opacity: CGFloat = 1) -> Self {
        overlay = BlurBuilder(style: style)
            .setOpacity(opacity)
        return self
    }
    
    @discardableResult
    public func setAnimation(_ duration: TimeInterval = 0.5) -> Self {
        animationDuration = duration
        return self
    }

    
//  MARK: - ACTIONS
    public func show() {
        isVisible = true
        
    }
    
    public func hide() {
        isVisible = false
    }
    
    
}
