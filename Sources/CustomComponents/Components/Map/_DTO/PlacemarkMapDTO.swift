//  Created by Alessandro Comparini on 19/06/24.
//

import Foundation

public struct PlacemarkMapDTO {
    public private(set) var street: String?
    public private(set) var addressNumber: String?
    public private(set) var neighborhood: String?
    public private(set) var postalCode: String?
    public private(set) var city: String?
    public private(set) var state: String?
    public private(set) var country: String?
    public private(set) var coordinate: (lat: Double, lon: Double)?
    
    init(street: String? = nil, addressNumber: String? = nil, neighborhood: String? = nil, postalCode: String? = nil, city: String? = nil, state: String? = nil, country: String? = nil, coordinate: (lat: Double, lon: Double)? = nil) {
        self.street = street
        self.addressNumber = addressNumber
        self.neighborhood = neighborhood
        self.postalCode = postalCode
        self.city = city
        self.state = state
        self.country = country
        self.coordinate = coordinate
    }
    
}
