//  Created by Alessandro Comparini on 09/04/24.
//

import Foundation

@MainActor
public protocol DropdownMenuEvents: AnyObject {
    func willAppearDropdowMenu()
    func didAppearDropdowMenu()
    func willDisappearDropdowMenu()
    func didDisappearDropdowMenu()
}


//  MARK: - EXTENSION
extension DropdownMenuEvents {
    func willAppearDropdowMenu() {}
    func willDisappearDropdowMenu() {}
}
