//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

open class ViewBuilder: BaseBuilder, ViewProtocol {
    public typealias T = UIView
    public var get: T { self.view }
    
    private var view: UIView
    

//  MARK: - INITIALIZERS
    public init(frame: CGRect) {
        self.view = UIView(frame: frame)
        super.init(view)
    }
    
    public init() {
        self.view = UIView(frame: .zero)
        super.init(view)
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setSize(width: Int, height: Int) -> Self {
        self.view.frame.size = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    public func setSize(_ size: CGSize) -> Self {
        self.view.frame.size = size
        return self
    }
    
}

