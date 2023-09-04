//
//  StartOfConstraintsFlowProtocol.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

open class StartOfConstraintsFlow: StartOfConstraintsFlowProtocol {
    private let mainElement: UIView
    private var _constraintVM: ConstraintsViewModel?
    private var listConstraints: [ConstraintsViewModel] = []

    public init(_ mainElement: UIView) {
        self.mainElement = mainElement
    }
    
    public var constraintVM: ConstraintsViewModel {
        get { self._constraintVM ?? ConstraintsViewModel()   }
        set { self._constraintVM = newValue }
    }
    
    
//  MARK: - CONSTRAINTS POSITION FLOW
    
    public var setTop: StartOfConstraintsPositionFlow<ConstraintsPositionY> {
        configStartFlow()
        constraintVM.mainAttribute(.top)
        return StartOfConstraintsPositionFlow<ConstraintsPositionY>(self)
    }
    
    public var setBottom: StartOfConstraintsPositionFlow<ConstraintsPositionY> {
        configStartFlow()
        constraintVM.mainAttribute(.bottom)
        return StartOfConstraintsPositionFlow<ConstraintsPositionY>(self)
    }
    
    public var setLeading: StartOfConstraintsPositionFlow<ConstraintsPositionX> {
        configStartFlow()
        constraintVM.mainAttribute(.leading)
        return StartOfConstraintsPositionFlow<ConstraintsPositionX>(self)
    }
    
    public var setTrailing: StartOfConstraintsPositionFlow<ConstraintsPositionX> {
        configStartFlow()
        constraintVM.mainAttribute(.trailing)
        return StartOfConstraintsPositionFlow<ConstraintsPositionX>(self)
    }
    
    public var setPin: EndOfConstraintsPositionFlow  {
        configStartFlow()
        _ = setTop.setBottom.setLeading.setTrailing
        return EndOfConstraintsPositionFlow(self)
    }
    
    public var setPinBottom: EndOfConstraintsPositionFlow  {
        configStartFlow()
        _ = setBottom.setLeading.setTrailing
        return EndOfConstraintsPositionFlow(self)
    }
    
    public var setPinTop: EndOfConstraintsPositionFlow  {
        configStartFlow()
        _ = setTop.setLeading.setTrailing
        return EndOfConstraintsPositionFlow(self)
    }
    
    public var setPinLeft: EndOfConstraintsPositionFlow  {
        configStartFlow()
        _ = setTop.setBottom.setLeading
        return EndOfConstraintsPositionFlow(self)
    }
    
    public var setPinRight: EndOfConstraintsPositionFlow  {
        configStartFlow()
        _ = setTop.setBottom.setTrailing
        return EndOfConstraintsPositionFlow(self)
    }
    
//  MARK: - CONSTRAINTS SIZE FLOW
    
    public var setWidth: StartOfConstraintsSizeFlowProtocol {
        configStartFlow()
        constraintVM.mainAttribute(.width)
        return StartOfConstraintsSizeFlow(self)
    }
    
    public var setHeight: StartOfConstraintsSizeFlowProtocol {
        configStartFlow()
        constraintVM.mainAttribute(.height)
        return StartOfConstraintsSizeFlow(self)
    }
    
    public var setSize: StartOfConstraintsSizeFlowProtocol {
        configStartFlow()
        _ = setHeight.setWidth
        return StartOfConstraintsSizeFlow(self)
    }

    
//  MARK: - CONSTRAINTS ALIGNMENTS
    
    public var setHorizontalAlignmentX: StartOfConstraintsAlignmentFlowProtocol {
        configStartFlow()
        constraintVM.mainAttribute(.horizontalX)
        return StartOfConstraintsAlignmentFlow(self)
    }
    
    public var setVerticalAlignmentY: StartOfConstraintsAlignmentFlowProtocol {
        configStartFlow()
        constraintVM.mainAttribute(.verticalY)
        return StartOfConstraintsAlignmentFlow(self)
    }
    
    public var setAlignmentCenterXY: StartOfConstraintsAlignmentFlowProtocol {
        configStartFlow()
        _ = setHorizontalAlignmentX.setVerticalAlignmentY
        return StartOfConstraintsAlignmentFlow(self)
    }
    
    
//  MARK: - INITIATE VIEWMODEL
    
    private func configStartFlow() {
        self.startViewModel()
        self.addConstraintFlow()
        self.setMainElement()
    }
    
    private func startViewModel() {
        self.constraintVM = ConstraintsViewModel()
    }
    
    private func addConstraintFlow() {
        self.listConstraints.append(self.constraintVM)
    }
    
    private func setMainElement() {
        self.constraintVM.mainElement = self.mainElement
    }
    
    @discardableResult
    public func apply() -> Self {
        let applyConstraint = ApplyConstraints(constraints: listConstraints)
        applyConstraint.apply()
        listConstraints.removeAll()
        _constraintVM = nil
        return self
    }
    
}



