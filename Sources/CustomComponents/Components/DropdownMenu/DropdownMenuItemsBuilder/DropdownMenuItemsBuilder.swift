//  Created by Alessandro Comparini on 05/04/24.
//

import UIKit

public class SectionBuilder {
    private(set) var section: ViewBuilder?
    private(set) var rows: [ViewBuilder] = []

    public init() {}
    
    public func setSection(_ view: ViewBuilder) -> Self {
        section = view
        return self
    }
    
    public func setRow(_ view: ViewBuilder) -> Self {
        rows.append(view)
        return self
    }
    
}


public class DropdownMenuItemsBuilder {
    
    public var sections: [SectionBuilder] = []
    public var rows: [ViewBuilder] = []
    
    public init() {  }
    
    
    @discardableResult
    public func setSection(_ build: (_ build: SectionBuilder) -> SectionBuilder) -> Self {
        let section = build(SectionBuilder())
        sections.append(section)
        return self
    }
    
    @discardableResult
    public func setRow(_ view: ViewBuilder) -> Self {
        rows.append(view)
        return self
    }
    
}
