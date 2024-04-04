//  Created by Alessandro Comparini on 04/04/24.
//

import UIKit

open class DropdownMenuBuilder: BaseBuilder, DropdownMenu {
    
    public var get: ViewBuilder { dropdownMenu }
    
    private var isApplyOnce = false
    private var zPosition: CGFloat = 10000
    private var isVisible = false
    private var superview = UIView()
    private var overlay: BlurBuilder?
    private var autoCloseEnabled = false
    private var excludeComponents = [UIView]()
    
    
//  MARK: - INITIALIZERS
    
    private var dropdownMenu: ViewBuilder
        
    public init() {
        dropdownMenu = ViewBuilder()
        super.init(dropdownMenu.get)
        configure()
    }

    
//  MARK: - GET PROPERTIES
    public func isShow() -> Bool { isVisible }

    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setAutoCloseMenuWhenTappedOut(excludeComponents: [UIView]) -> Self {
        autoCloseEnabled = true
        self.excludeComponents = excludeComponents
        return self
    }
    
    @discardableResult
    public func setOverlay(style: UIBlurEffect.Style, _ opacity: CGFloat = 1) -> Self {
        overlay = BlurBuilder(style: style)
            .setOpacity(opacity)
        return self
    }
    

//  MARK: - SHOW and HIDE
    
    public func show() {
        isVisible = true
        dropdownMenu.setHidden(false)
        applyOnce()
    }
    
    public func hide() {
        isVisible = false
        dropdownMenu.setHidden(true)
    }
    
    private func applyOnce() {
        if isApplyOnce {return}
        
        getSuperview()
        
        configOverlay()
        
        configHierarchyDropdownMenu()
        
        isApplyOnce = true
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        hide()
    }
    
    private func getSuperview() {
        guard let superview = dropdownMenu.get.superview else {return}
        self.superview = superview
    }
    
    private func configOverlay() {
        self.overlay?
            .setAutoLayout { build in
                build
                    .pin.equalToSuperview()
            }

        overlay?.get.layer.zPosition = zPosition
        overlay?.add(insideTo: superview)
        overlay?.applyAutoLayout()
    }
    
    private func configHierarchyDropdownMenu() {
        dropdownMenu.get.layer.zPosition = zPosition + 1
    }
    

    
}
