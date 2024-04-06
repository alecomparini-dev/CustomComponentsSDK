//  Created by Alessandro Comparini on 04/04/24.
//

import UIKit

open class DropdownMenuBuilder: BaseBuilder, DropdownMenu {
    
    public var get: ViewBuilder { dropdownMenu }

    private var animationDuration: TimeInterval = 0
    private var isApplyOnce = false
    private var zPosition: CGFloat = 10000
    private var isVisible = false
    private var superview = UIView()
    private var overlay: BlurBuilder?
    private var autoCloseEnabled = false
    private var excludeComponents = [UIView]()
    private var tap: TapGestureBuilder?
    
    private var dropdownMenuList: ListBuilder?
    private var dropdownMenuItems: DropdownMenuItemsBuilder?

//    private var dropdownMenuFooterView: DropdownMenuFooterView!
    private var footerView: BaseBuilder?
    private var heightFooterView: CGFloat = 0
    
    
    
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
    public func setCloseMenuWhenTappedOut(excludeComponents: [UIView]) -> Self {
        autoCloseEnabled = true
        self.excludeComponents = excludeComponents
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
    
    
    
//  MARK: - CONFIG LIST
    @discardableResult
    public func setConfigList(style: K.List.Style = .grouped, _ build: (_ build: ListBuilder) -> ListBuilder) -> Self {
        dropdownMenuList = build(ListBuilder(style: UITableView.Style(rawValue: style.rawValue) ?? .grouped  ))
        return self
    }
    
    
//  MARK: - POPULATE DATA
    
    @discardableResult
    public func setPopulateItems(_ build: (_ build: DropdownMenuItemsBuilder) -> DropdownMenuItemsBuilder) -> Self {
        dropdownMenuItems = build(DropdownMenuItemsBuilder())
        return self
    }

    
//  MARK: - CONFIG FOOTER VIEW
    @discardableResult
    public func setConfigFooterView(height: CGFloat, _ view: ViewBuilder) -> Self {
        footerView = view
        heightFooterView = height
        return self
    }


//  MARK: - SHOW and HIDE
    
    public func show() {
        isVisible = true
        applyOnce()
        showAnimation()
    }
    
    public func hide() {
        isVisible = false
        hideAnimation { [weak self] in
            guard let self else {return }
            dropdownMenu.setHidden(true)
            overlay?.setHidden(true)
        }
        
    }
    
    
//  MARK: - PRIVATE AREA
    private func applyOnce() {
        if isApplyOnce {return}
        
        getSuperview()
        
        configOverlay()
        
        configHierarchyVisualization()
        
        configAutoCloseDropdownMenu()

        configFooterView()
        
        configList()
        
        isApplyOnce = true
    }
    
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

        overlay?.add(insideTo: superview)
        overlay?.applyAutoLayout()
    }
    
    private func configHierarchyVisualization() {
        overlay?.get.layer.zPosition = zPosition
        dropdownMenu.get.layer.zPosition = zPosition + 1
        excludeComponents.forEach { comp in
            comp.layer.zPosition = self.zPosition + 1
        }
        bringToFront()
    }
    
    private func bringToFront() {
        superview.bringSubviewToFront(dropdownMenu.get)
        excludeComponents.forEach { comp in
            superview.bringSubviewToFront(comp)
        }
    }
    
    private func configAutoCloseDropdownMenu() {
        if autoCloseEnabled {
            _ = TapGestureBuilder(superview)
                .setCancelsTouchesInView(false)
                .setTap({ [weak self] tapGesture in
                    self?.verifyTappedOutMenu(tapGesture)
                })
        }
    }
    
    private func verifyTappedOutMenu(_ tap: TapGestureBuilder?) {
        if isShow() {
            if isTappedOut(tap) { hide() }
        }
    }
    
    private func isTappedOut(_ tap: TapGestureBuilder?) -> Bool {
        guard let tap else {return false}
        let touchPoint = tap.getTouchPosition(.superview)
        if isTappedOutDropdownMenu(touchPoint) && isTappedOutExcludeComponents(touchPoint) { return true }
        return false
    }
    
    private func isTappedOutDropdownMenu(_ touchPoint: CGPoint) -> Bool {
        if dropdownMenu.get.frame.contains(touchPoint) { return false }
        return true
    }
    
    private func isTappedOutExcludeComponents(_ touchPoint: CGPoint) -> Bool {
        var isTappedOut = true
        excludeComponents.forEach { comp in
            if comp.frame.contains(touchPoint) {
                isTappedOut = false
                return
            }
        }
        return isTappedOut
    }
    
    private func configFooterView() {
        let dropdownMenuFooterView = DropdownMenuFooterView(height: heightFooterView)
        dropdownMenuFooterView.add(insideTo: dropdownMenu)
        dropdownMenuFooterView.applyLayout()
        
        guard let footerView else {return}
        footerView.add(insideTo: dropdownMenuFooterView)
        footerView.setAutoLayout { build in
            build.pin.equalToSuperview()
                .apply()
        }
    }
    
    private func configList() {
        addListOnDropdowMenu()
        configConstraintsList()
        configDelegate()
        dropdownMenuList?.show()
    }
    
    private func addListOnDropdowMenu() {
        dropdownMenuList?.add(insideTo: dropdownMenu)
    }
    
    private func configConstraintsList() {
        dropdownMenuList?.setAutoLayout({ build in
            build
                .pin.equalToSuperview()
                .apply()
        })
        
        let padding: UIEdgeInsets!
        padding = dropdownMenuList?.get.contentInset
        
        dropdownMenuList?.setPadding(top: padding.top,
                                     left: padding.left,
                                     bottom: padding.bottom + heightFooterView,
                                     right: padding.right)
        
    }
    
    private func configDelegate() {
        dropdownMenuList?.setDelegate(self)
    }
    
    
    
//  MARK: - ANIMATIONS AREA
    private func showAnimation(_ completion: (() -> Void)? = nil) {
        configStartAnimation()
        UIView.animate(withDuration: animationDuration) { [weak self] in
            guard let self else {return}
            dropdownMenu.get.alpha = 1
            overlay?.get.alpha = 1
        } completion: { bool in
            if bool {
                completion?()
            }
        }
    }
    
    private func configStartAnimation() {
        dropdownMenu.setAlpha(0)
        overlay?.setAlpha(0)
        dropdownMenu.setHidden(false)
        overlay?.setHidden(false)
    }
    
    private func hideAnimation(_ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: animationDuration) { [weak self] in
            guard let self else {return}
            dropdownMenu.get.alpha = 0
            overlay?.get.alpha = 0
        } completion: { [weak self] bool in
            guard let self else {return}
            if bool {
                dropdownMenu.setHidden(true)
                overlay?.setHidden(true)
                completion?()
            }
        }
    }
    
}


//  MARK: - EXTENSION
extension DropdownMenuBuilder: ListDelegate {
    public func numberOfSections(_ list: ListBuilder) -> Int {
        dropdownMenuItems?.get.count ?? 0
    }
    
    public func numberOfRows(_ list: ListBuilder, section: Int) -> Int {
        dropdownMenuItems?.get[section].rows.count ?? 0
    }
    
    public func sectionViewCallback(_ list: ListBuilder, section: Int) -> UIView? {
        nil
    }
    
    public func rowViewCallBack(_ list: ListBuilder, section: Int, row: Int) -> Any {
        return dropdownMenuItems?.get[section].rows[row] ?? UIView()
    }
    
    
}
