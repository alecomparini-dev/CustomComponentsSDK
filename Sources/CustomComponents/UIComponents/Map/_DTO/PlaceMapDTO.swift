//  Created by Alessandro Comparini on 26/11/24.
//


public struct PlaceMapDTO {
    public let title: String?
    public let subtitle: String?
    public let name: String?
    public let isCurrentLocation: Bool?
    public let street: String?
    public let number: String?
    public let neighborhood: String?
    public let city: String?
    public let UF: String?
    public let postalCode: String?
    public let country: String?
    public let phoneNumber: String?
    public let coordinate: (lat: Double, lon: Double)?
    public let pointOfInterestCategory: String?
    
    init(title: String? = nil,
         subtitle: String? = nil,
         name: String? = nil,
         isCurrentLocation: Bool? = false,
         street: String? = nil,
         number: String? = nil,
         neighborhood: String? = nil,
         city: String? = nil,
         UF: String? = nil,
         postalCode: String? = nil,
         country: String? = nil,
         phoneNumber: String? = nil,
         coordinate: (lat: Double, lon: Double)? = nil,
         pointOfInterestCategory: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.name = name
        self.isCurrentLocation = isCurrentLocation
        self.street = street
        self.number = number
        self.neighborhood = neighborhood
        self.city = city
        self.UF = UF
        self.postalCode = postalCode
        self.country = country
        self.phoneNumber = phoneNumber
        self.coordinate = coordinate
        self.pointOfInterestCategory = pointOfInterestCategory
    }
}
