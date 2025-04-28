//
//  ConstraintsViewModel.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 19/04/23.
//

import UIKit

open class ConstraintsViewModel {
    
    private var model: ConstraintsModel
    
    public init() {
        self.model = ConstraintsModel()
    }

    public var getConstraint: ConstraintsModel {
        return model
    }

    public var mainElement: UIView {
        get { model.mainElement }
        set { model.mainElement = newValue}
    }
    
    public var mainAttribute: [ConstraintsAttribute] { model.mainAttribute }
    
    public func mainAttribute(_ value: ConstraintsAttribute) {
        model.mainAttribute.append(value)
    }
    
    public var typeElement: ConstraintsTypeElement { model.typeElement }
    
    public var relation: ConstraintsRelations { model.relation }
    
    
    
    public func equalTo(_ element: UIView, _ attribute: ConstraintsAttribute? = nil, _ constant: CGFloat? = nil) {
        updateRelations(.equalTo, element, attribute, constant)
    }
    
    public func equalTo(_ element: UIView, _ constant: CGFloat? = nil) {
        updateRelations(.equalTo, element, nil, constant)
    }
    
    public func greaterThanOrEqualTo(_ element: UIView, _ attribute: ConstraintsAttribute? = nil, _ constant: CGFloat? = nil) {
        updateRelations(.greaterThanOrEqualTo, element, attribute, constant)
    }
    
    public func lessThanOrEqualTo(_ element: UIView, _ attribute: ConstraintsAttribute? = nil, _ constant: CGFloat? = nil) {
        updateRelations(.lessThanOrEqualTo, element, attribute, constant)
    }
    

    
//  MARK: - SAFE AREA
    public func equalToSafeArea(_ constant: CGFloat = 0) {
        model.typeElement = .safeArea
        updateRelations(.equalTo, constant)
    }
    
    public func lessThanOrEqualToSafearea(_ constant: CGFloat = 0) {
        model.typeElement = .safeArea
        updateRelations(.lessThanOrEqualTo, constant)
    }
    
    public func greaterThanOrEqualToSafearea(_ constant: CGFloat = 0) {
        model.typeElement = .safeArea
        updateRelations(.greaterThanOrEqualTo, constant)
    }
    
    

//  MARK: - SUPERVIEW
    public func equalToSuperview(_ constant: CGFloat = 0) {
        model.typeElement = .superview
        updateRelations(.equalTo, constant)
    }
    
    public func lessThanOrEqualToSuperview(_ constant: CGFloat = 0) {
        model.typeElement = .superview
        updateRelations(.lessThanOrEqualTo, constant)
    }
    
    public func greaterThanOrEqualToSuperview(_ constant: CGFloat = 0) {
        model.typeElement = .superview
        updateRelations(.greaterThanOrEqualTo, constant)
    }
    
    
//  MARK: - Constant
    public func equalToConstant(_ constant: CGFloat) {
        updateRelations(.equalTo, constant)
    }
    
    public func lessThanOrEqualToConstant(_ constant: CGFloat) {
        updateRelations(.lessThanOrEqualTo, constant)
    }
    
    public func greaterThanOrEqualToConstant(_ constant: CGFloat) {
        updateRelations(.greaterThanOrEqualTo, constant)
    }
    
    public var toItem: UIView? {
        get { model.toItem }
        set { model.toItem = newValue}
    }
    
    public var toAttribute: ConstraintsAttribute? {
        get { model.toAttribute }
        set { model.toAttribute = newValue}
    }
    
    public var constant: CGFloat? {
        get { model.constant }
        set { model.constant = newValue ?? 0}
    }
    
    public var multiplier: CGFloat{
        get { model.multiplier }
        set { model.multiplier = newValue}
    }

    func startModel() {
        self.model = ConstraintsModel()
    }
    
    
    private func updateRelations(_ relation: ConstraintsRelations, _ toItem: UIView? = nil, _ attribute: ConstraintsAttribute? = nil, _ constant: CGFloat? = nil) {
        model.relation = relation
        self.toItem = toItem
        self.toAttribute = attribute
        self.constant = constant ?? 0
    }
    
    private func updateRelations(_ relation: ConstraintsRelations, _ constant: CGFloat) {
        self.updateRelations(relation, nil, nil, constant )
    }
    
}
