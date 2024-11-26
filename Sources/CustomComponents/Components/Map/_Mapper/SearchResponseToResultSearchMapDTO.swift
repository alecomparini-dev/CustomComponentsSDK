//  Created by Alessandro Comparini on 26/11/24.
//

import MapKit

struct SearchResponseToResultSearchMapDTO {
    
    static func mapper(_ response: MKLocalSearch.Response) -> [ResultSearchMapDTO] {
        return response.mapItems.map({
            
            let subtitle = makeSubtitle($0.placemark)
            
            return ResultSearchMapDTO(title: $0.placemark.title,
                                      subtitle: subtitle,
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
    
    static private func makeSubtitle(_ placemark: MKPlacemark) -> String? {
        let name = placemark.name
        let street = placemark.thoroughfare ?? ""
        let number = (placemark.subThoroughfare == nil) ? "" : ", \(placemark.subThoroughfare ?? "")"
        let neighborhood = (placemark.subLocality == nil) ? "" : ", \(placemark.subLocality ?? "")"
        let city = (placemark.locality == nil) ?  "" : " - \(placemark.locality ?? "")"
        let uf = placemark.administrativeArea ?? ""
        
        let address = "\(street)\(number)"
        let additional = "\(neighborhood)\(city)\(uf)"
        
        if name != nil {
            return address
        }
        
        return address + additional
    }
}
