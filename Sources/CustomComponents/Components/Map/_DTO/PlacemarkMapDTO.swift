//  Created by Alessandro Comparini on 19/06/24.
//

import Foundation

public struct PlacemarkMap {
    private(set) var street: String?
    private(set) var addressNumber: String?
    private(set) var neighborhood: String?
    private(set) var postalCode: String?
    private(set) var city: String?
    private(set) var state: String?
    private(set) var country: String?
    private(set) var coordinate: (lat: Double, lon: Double)?
    
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
