//  Created by Alessandro Comparini on 29/02/24.
//

import Foundation

public protocol MapBuilderOutput: AnyObject {
    
    func finishFullyRenderedMap()
    
    func localizationNotAuthorized()
    
    func localizationAuthorized()
    
    func loadingMapError(_ error: String)
    
    func pinSelected(title: String, subtitle: String, coordinate: (lat: Double, lon: Double))
    
    func pinDeselected(title: String, subtitle: String, coordinate: (lat: Double, lon: Double))
    
    func fetchPlacesAutoCompleterSuccess(resultSearchMapDTO: [ResultSearchMapDTO])
    
    func fetchPlacesSuccess(resultSearchMapDTO: [ResultSearchMapDTO])
    
    func fetchSearchError(error: Error)
}
