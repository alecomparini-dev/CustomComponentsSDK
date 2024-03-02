//  Created by Alessandro Comparini on 01/03/24.
//

import UIKit

public class StartAutoLayout {
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
    
    

//  MARK: - LAYOUT ALIGNMENT
    
    public var horizontalAlignX: StartAlignConstraintFlow {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.centerX)
        return StartAlignConstraintFlow(self)
    }
    
    public var verticalAlignY: StartAlignConstraintFlow {
        configStartAutoLayout()
        autoLayout.mainAttribute.append(.centerY)
        return StartAlignConstraintFlow(self)
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



