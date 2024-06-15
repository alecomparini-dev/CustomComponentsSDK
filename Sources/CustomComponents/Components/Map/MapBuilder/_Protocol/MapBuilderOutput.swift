//  Created by Alessandro Comparini on 29/02/24.
//

import Foundation

@MainActor
public protocol MapBuilderOutput: AnyObject {
    func finishFullyRenderedMap()
    
    func localizationNotAuthorized()
    
    func loadingMapError(_ error: String)
    
    func pinSelected(title: String, subtitle: String, coordinate: (lat: Double, lon: Double))
    
    func pinDeselected()
    
}
