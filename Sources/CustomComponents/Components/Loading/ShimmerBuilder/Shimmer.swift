//  Created by Alessandro Comparini on 20/10/23.
//

import Foundation

public protocol Shimmer {
    
    func startCovering(_ view: BaseBuilder?, with identifiers: [String]?)

    func stopCovering(_ view: BaseBuilder?)

}
