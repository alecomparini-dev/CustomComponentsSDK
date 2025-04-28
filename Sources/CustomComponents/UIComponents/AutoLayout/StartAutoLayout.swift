//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

@MainActor
open class StartAutoLayout {
    private weak var mainElement: UIView?
    private var listAutoLayout = [AutoLayout]()
    var autoLayout: AutoLayout!
    
    public init(element: UIView) {
        self.mainElement = element
    }

    
//  MARK: - LAYOUT POSITION
    
    public var top: StartPositionConstraintFlow<ConstraintsPositionY> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.top)
        return StartPositionConstraintFlow<ConstraintsPositionY>(self)
    }
    
    public var bottom: StartPositionConstraintFlow<ConstraintsPositionY> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.bottom)
        return StartPositionConstraintFlow<ConstraintsPositionY>(self)
    }
    
    public var leading: StartPositionConstraintFlow<ConstraintsPositionX> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.leading)
        return StartPositionConstraintFlow<ConstraintsPositionX>(self)
    }
    
    public var trailing: StartPositionConstraintFlow<ConstraintsPositionX> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.trailing)
        return StartPositionConstraintFlow<ConstraintsPositionX>(self)
    }
    
    
//  MARK: - LAYOUT POSITION WITH PRIORITY
    
    public func top(priority: UILayoutPriority) -> StartPositionConstraintFlow<ConstraintsPositionY> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.top)
        autoLayout.priority = priority
        return StartPositionConstraintFlow<ConstraintsPositionY>(self)
    }
    
    public func bottom(priority: UILayoutPriority) -> StartPositionConstraintFlow<ConstraintsPositionY> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.bottom)
        autoLayout.priority = priority
        return StartPositionConstraintFlow<ConstraintsPositionY>(self)
    }
    
    public func leading(priority: UILayoutPriority) -> StartPositionConstraintFlow<ConstraintsPositionX> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.leading)
        autoLayout.priority = priority
        return StartPositionConstraintFlow<ConstraintsPositionX>(self)
    }
    
    public func trailing(priority: UILayoutPriority) -> StartPositionConstraintFlow<ConstraintsPositionX> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.trailing)
        autoLayout.priority = priority
        return StartPositionConstraintFlow<ConstraintsPositionX>(self)
    }
    
    
//  MARK: - PIN
    public var pin: EndPositionConstraintFlow  {
        configStartAutoLayout()
        _ = top.bottom.leading.trailing
        return EndPositionConstraintFlow(self)
    }
    
    public var pinBottom: EndPositionConstraintFlow  {
        configStartAutoLayout()
        _ = bottom.leading.trailing
        return EndPositionConstraintFlow(self)
    }
    
    public var pinTop: EndPositionConstraintFlow  {
        configStartAutoLayout()
        _ = top.leading.trailing
        return EndPositionConstraintFlow(self)
    }
    
    public var pinLeft: EndPositionConstraintFlow  {
        configStartAutoLayout()
        _ = top.bottom.leading
        return EndPositionConstraintFlow(self)
    }
    
    public var pinRight: EndPositionConstraintFlow  {
        configStartAutoLayout()
        _ = top.bottom.trailing
        return EndPositionConstraintFlow(self)
    }

    
//  MARK: - LAYOUT DIMENSION
    
    public var width: StartDimensionConstraintFlow<ConstraintsSize> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.width)
        return StartDimensionConstraintFlow<ConstraintsSize>(self)
    }
    
    public var height: StartDimensionConstraintFlow<ConstraintsSize> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.height)
        return StartDimensionConstraintFlow<ConstraintsSize>(self)
    }
    
    public var size: StartDimensionConstraintFlow<ConstraintsSize> {
        configStartAutoLayout()
        _ = width.height
        return StartDimensionConstraintFlow<ConstraintsSize>(self)
    }

    
//  MARK: - LAYOUT DIMENSION - PRIORITY
    
    public func width(priority: UILayoutPriority) -> StartDimensionConstraintFlow<ConstraintsSize> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.width)
        autoLayout.priority = priority
        return StartDimensionConstraintFlow<ConstraintsSize>(self)
    }
    
    public func height(priority: UILayoutPriority) -> StartDimensionConstraintFlow<ConstraintsSize> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.height)
        autoLayout.priority = priority
        return StartDimensionConstraintFlow<ConstraintsSize>(self)
    }
    

//  MARK: - LAYOUT ALIGNMENT
    
    public var horizontalAlignX: StartAlignConstraintFlow<ConstraintsPositionX> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.horizontalX)
        return StartAlignConstraintFlow<ConstraintsPositionX>(self)
    }
    
    public var verticalAlignY: StartAlignConstraintFlow<ConstraintsPositionY> {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.verticalY)
        return StartAlignConstraintFlow<ConstraintsPositionY>(self)
    }
    
    public var centerAlignXY: EndAlignConstraintFlow {
        configStartAutoLayout()
        _ = horizontalAlignX.verticalAlignY
        return EndAlignConstraintFlow(self)
    }
    
    
//  MARK: - PRIVATE AREA
    private func configStartAutoLayout() {
        startAutoLayout()
        addNewAutoLayout()
    }
    
    private func startAutoLayout() {
        guard let mainElement = self.mainElement else {return}
        self.autoLayout = AutoLayout(mainElement: mainElement)
    }
        
    private func addNewAutoLayout() {
        listAutoLayout.append(self.autoLayout)
    }
    
    @discardableResult
    public func apply() -> Self {
        let applyAutoLayout = ApplyAutoLayout(listAutoLayout)
        applyAutoLayout.apply()
        listAutoLayout.removeAll()
        autoLayout = nil
        mainElement = nil
        return self
    }
    
    
        
}



