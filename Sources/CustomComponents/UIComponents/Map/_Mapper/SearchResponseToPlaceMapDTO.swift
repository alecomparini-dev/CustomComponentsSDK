//  Created by Alessandro Comparini on 26/11/24.
//

import MapKit

struct SearchResponseToPlaceMapDTO {
    
    static func mapper(_ response: MKLocalSearch.Response) -> [PlaceMapDTO] {
        return response.mapItems.map({
            
            PlaceMapDTO(title: $0.placemark.name,
                        subtitle: $0.placemark.title,
                        name: $0.placemark.name,
                        isCurrentLocation: $0.isCurrentLocation,
                        street: $0.placemark.thoroughfare,
                        number: $0.placemark.subThoroughfare,
                        neighborhood: $0.placemark.subLocality,
                        city: $0.placemark.locality,
                        UF: $0.placemark.administrativeArea,
                        postalCode: $0.placemark.postalCode,
                        country: $0.placemark.country,
                        phoneNumber: $0.phoneNumber,
                        coordinate: ($0.placemark.coordinate.latitude, $0.placemark.coordinate.longitude),
                        pointOfInterestCategory: $0.pointOfInterestCategory?.rawValue)
        })
    }
    
}
