//  Created by Alessandro Comparini on 09/04/24.
//

import Foundation

@MainActor
public protocol DropdownMenuEvents: AnyObject {
    func willAppearDropdownMenu()
    func didAppearDropdownMenu()
    func willDisappearDropdownMenu()
    func didDisappearDropdownMenu()
}


//  MARK: - EXTENSION
extension DropdownMenuEvents {
    func willAppearDropdownMenu() {}
    func willDisappearDropdownMenu() {}
}
