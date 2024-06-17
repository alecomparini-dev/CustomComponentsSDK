//  Created by Alessandro Comparini on 14/05/24.
//

import Foundation

@MainActor
public protocol ScrollView {
    associatedtype S
    
    var get: S { get }
    
    @discardableResult
    func setShowsVerticalScrollIndicator(_ flag: Bool) -> Self
    
    @discardableResult
    func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self
    
    @discardableResult
    func setPaddingInputToKeyboard(_ padding: CGFloat) -> Self
    
    @discardableResult
    func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self

    @discardableResult
    func setVerticalScrollIndicatorInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self
    
}
