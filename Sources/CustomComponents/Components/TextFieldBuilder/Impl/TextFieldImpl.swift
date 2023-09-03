//  Created by Alessandro Comparini on 03/09/23.
//

import UIKit

open class TextFieldImpl: BaseBuilder, TextField {
    public typealias T = UITextField
    public var get: UITextField { self.textField }
    
    private var textField: UITextField
    

//  MARK: - INITIALIZERS
    public init() {
        self.textField = UITextField()
        super.init(textField)
    }
    
    
    
    
}
