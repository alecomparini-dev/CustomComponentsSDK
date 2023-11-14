//  Created by Alessandro Comparini on 02/09/23.
//

import Foundation

public protocol Button {
    associatedtype T
    var get: T { get }
    
    @discardableResult
    func setTitle(_ title: String?) -> Self

    @discardableResult
    func setTitleColor(hexColor color: String?) -> Self
    
    @discardableResult
    func setTitleColor(named color: String?) -> Self
    
    @discardableResult
    func setTintColor(hexColor color: String?) -> Self
    
    @discardableResult
    func setTintColor(named color: String?) -> Self
    
    @discardableResult
    func setTitleAlignment(_ textAlignment: K.Text.Alignment?) -> Self
    
    @discardableResult
    func setTitleSize(_ fontSize: CGFloat? ) -> Self
    
    @discardableResult
    func setFontFamily(_ fontFamily: String?, _ fontSize: CGFloat? ) -> Self
        
    @discardableResult
    func setItalicFont() -> Self
        
    @discardableResult
    func setTitleWeight(_ weight: K.Weight? ) -> Self
    
    
    
//  MARK: - LOADING INDICATOR
    @discardableResult
    func setShowLoadingIndicator(_ build: (_ build: LoadingBuilder) -> LoadingBuilder) -> Self
    
    @discardableResult
    func setShowLoadingIndicator(_ styleIndicator: K.ActivityIndicator.Style) -> Self
    
    @discardableResult
    func setHideLoadingIndicator() -> Self
    
}
