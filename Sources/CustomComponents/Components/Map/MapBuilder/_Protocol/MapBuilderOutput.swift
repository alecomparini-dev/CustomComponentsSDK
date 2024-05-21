//  Created by Alessandro Comparini on 29/02/24.
//

import Foundation

public protocol MapBuilderOutput: AnyObject {
    func finishFullyRenderedMap()
    
    func localizationNotAuthorized()
    
    func loadingMapError(_ error: String)
    
}
