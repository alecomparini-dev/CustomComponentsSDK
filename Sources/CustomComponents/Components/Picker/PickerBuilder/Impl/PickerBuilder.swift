//  Created by Alessandro Comparini on 04/12/23.
//

import UIKit

public protocol PickerDelegate: AnyObject {
    func numberOfComponents() -> Int
    func numberOfRows(forComponent: Int) -> Int
    func rowViewCallBack(component: Int, row: Int, reusing: UIView?) -> UIView
    func attributedStringCallBack(component: Int, row: Int) -> NSAttributedString?
    func didSelectRowAt(_ component: Int, _ row: Int)
}


open class PickerBuilder: BaseBuilder, Picker {
    private weak var delegate: PickerDelegate?
    
    public var get: UIPickerView { picker }
    
    private var isShow: Bool = false
    private var alreadyApplied = false
    private var rowHeight: CGFloat = 40
    
    
//  MARK: - INITIALIZERS
    private let picker: T
    
    public init() {
        self.picker = UIPickerView()
        super.init(picker)
    }
    

//  MARK: - GET PROPERTIES
    
    public func getRowSelected(inComponent: Int = 0) -> Int {
        return picker.selectedRow(inComponent: inComponent)
    }
    
    
//  MARK: - SET PROPERTIES
    @discardableResult
    public func setRowHeight(_ height: CGFloat) -> Self {
        rowHeight = height
        return self
    }
    
    public var isShowing: Bool { isShow }
    
    
//  MARK: - ACTION AREA
    public func show() {
        if isShow { return }
        isShow = true
        applyOnceConfig()
        picker.setHidden(false)
    }
    
    public func hide() {
        isShow = false
        picker.setHidden(true)
    }
    
    public func reload(component: Int? = 0) {
        if let component {
            picker.reloadComponent(component)
            return
        }
        picker.reloadAllComponents()
    }
    
    public func selectItem(component: Int = 0, _ row: Int) {
        picker.selectRow(row, inComponent: component, animated: true)
        delegate?.didSelectRowAt(component, row)
    }
    
    
//  MARK: - SET DELEGATE
    
    @discardableResult
    public func setDelegate(_ delegate: PickerDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    
//  MARK: - PRIVATE AREA
    
    private func applyOnceConfig() {
        if alreadyApplied { return }
        alreadyApplied = true
        configurePickerDelegate()
    }
    
    private func configurePickerDelegate() {
        picker.delegate = self
        picker.dataSource = self
    }
}


//  MARK: - EXTENSION - UIPickerViewDataSource

extension PickerBuilder: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return delegate?.numberOfComponents() ?? 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return delegate?.numberOfRows(forComponent: component) ?? 1
    }
    
}


//  MARK: - EXTENSION - UIPickerViewDelegate
extension PickerBuilder: UIPickerViewDelegate {

    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectItem(component: component, row)
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return delegate?.attributedStringCallBack(component: component, row: row)
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return delegate?.rowViewCallBack(component: component, row: row, reusing: view) ?? UIView()
    }
    
}
