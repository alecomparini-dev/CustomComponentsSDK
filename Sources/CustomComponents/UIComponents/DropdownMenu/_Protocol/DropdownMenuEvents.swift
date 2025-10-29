//  Created by Alessandro Comparini on 09/04/24.
//

import Foundation

@MainActor
public protocol DropdownMenuEvents: AnyObject {
    func willAppearDropdownMenu(_ dropdown: DropdownMenuBuilder)
    func didAppearDropdownMenu(_ dropdown: DropdownMenuBuilder)
    func willDisappearDropdownMenu(_ dropdown: DropdownMenuBuilder)
    func didDisappearDropdownMenu(_ dropdown: DropdownMenuBuilder)
}


//  MARK: - EXTENSION
extension DropdownMenuEvents {
    func willAppearDropdownMenu(_ dropdown: DropdownMenuBuilder) {}
    func willDisappearDropdownMenu(_ dropdown: DropdownMenuBuilder) {}
}
