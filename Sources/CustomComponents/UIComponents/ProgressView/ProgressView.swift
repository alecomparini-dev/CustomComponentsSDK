//  Created by Alessandro Comparini on 30/04/24.
//

import Foundation

@MainActor
public protocol ProgressView {
    associatedtype P
    
    var get: P { get }
    
    @discardableResult
    func setProgress(_ percent: Float) -> Self
    
    @discardableResult
    func setTrackColor(hexColor: String) -> Self
    
    @discardableResult
    func setProgressColor(hexColor: String) -> Self
    
    
}
