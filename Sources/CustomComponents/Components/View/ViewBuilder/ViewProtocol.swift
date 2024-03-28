//  Created by Alessandro Comparini on 03/09/23.
//

import Foundation

public protocol ViewProtocol {
    associatedtype T
    var get: T { get }

    
    func setSize(width: Int, height: Int) -> Self
    
    func setSize(_ size: CGSize) -> Self


}
