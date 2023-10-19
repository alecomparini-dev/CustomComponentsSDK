//  Created by Alessandro Comparini on 17/10/23.
//

import UIKit

public class LoadingBuilder: BaseBuilder , Loading {
    public typealias T = UIActivityIndicatorView
    public var get: UIActivityIndicatorView { self.loading }

    private let loading: UIActivityIndicatorView
        
    public init() {
        self.loading = UIActivityIndicatorView()
        super.init(loading)
    }
    

//  MARK: - SET PROPERTIES
    @discardableResult
    public func setColor(color: UIColor?) -> Self {
        guard let color else {return self}
        loading.color = color
        return self
    }
    
    @discardableResult
    public func setColor(hexColor color: String?) -> Self {
        guard let color, color.isHexColor() else {return self}
        setColor(color: UIColor.HEX(color))
        return self
    }
    
    @discardableResult
    public func setStyle(_ style: K.ActivityIndicator.Style) -> Self {
        loading.style = UIActivityIndicatorView.Style(rawValue: style.rawValue) ?? .medium
        return self
    }
    
    @discardableResult
    public func setHideWhenStopped(_ hide: Bool) -> Self {
        loading.hidesWhenStopped = hide
        return self
    }
    
    public func setStartAnimating() {
        loading.startAnimating()
    }
    
    public func setStopAnimating() {
        loading.stopAnimating()
    }
    
}
