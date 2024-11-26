//  Created by Alessandro Comparini on 26/11/24.
//


public struct ResultSearchMapDTO {
    public let title: String?
    public let subtile: String?
    public let name: String?
    public let isCurrentLocation: Bool?
    public let street: String? // thoroughfare
    public let number: String? // subThoroughfare
    public let neighborhood: String? // subLocality
    public let city: String? //
    public let state: String? // subAdministrativeArea
    public let UF: String? // administrativeArea
    public let postalCode: String? // locality
    public let country: String?
    public let phoneNumber: String?
    public let coordinate: (lat: Double, lon: Double)?
    public let pointOfInterestCategory: String?
    
    init(title: String? = nil,
         subtile: String? = nil,
         name: String? = nil,
         isCurrentLocation: Bool? = false,
         street: String? = nil,
         number: String? = nil,
         neighborhood: String? = nil,
         city: String? = nil,
         state: String? = nil,
         UF: String? = nil,
         postalCode: String? = nil,
         country: String? = nil,
         phoneNumber: String? = nil,
         coordinate: (lat: Double, lon: Double)? = nil,
         pointOfInterestCategory: String? = nil) {
        self.title = title
        self.subtile = subtile
        self.name = name
        self.isCurrentLocation = isCurrentLocation
        self.street = street
        self.number = number
        self.neighborhood = neighborhood
        self.city = city
        self.state = state
        self.UF = UF
        self.postalCode = postalCode
        self.country = country
        self.phoneNumber = phoneNumber
        self.coordinate = coordinate
        self.pointOfInterestCategory = pointOfInterestCategory
    }
}
