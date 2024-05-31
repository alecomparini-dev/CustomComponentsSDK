//  Created by Alessandro Comparini on 26/09/23.
//

import Foundation

@MainActor
public protocol ViewController {
    associatedtype T
    var get: T { get }
}
