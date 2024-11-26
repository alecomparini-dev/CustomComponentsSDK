//  Created by Alessandro Comparini on 26/11/24.
//

import MapKit

struct SearchResponseToResultSearchMapDTO {
    
    static func mapper(_ response: MKLocalSearch.Response) -> [ResultSearchMapDTO] {
        return response.mapItems.map({
            ResultSearchMapDTO(title: $0.placemark.title,
                               subtitle: $0.placemark.subtitle,
                               name: $0.placemark.name,
                               isCurrentLocation: $0.isCurrentLocation,
                               street: $0.placemark.thoroughfare,
                               number: $0.placemark.subThoroughfare,
                               neighborhood: $0.placemark.subLocality,
                               city: $0.placemark.locality,
                               state: $0.placemark.subAdministrativeArea,
                               UF: $0.placemark.administrativeArea,
                               postalCode: $0.placemark.postalCode,
                               country: $0.placemark.country,
                               phoneNumber: $0.phoneNumber,
                               pointOfInterestCategory: $0.pointOfInterestCategory?.rawValue)
        })
    }
}
