//  Created by Alessandro Comparini on 27/02/24.
//

import UIKit

public class ClearButtonModeBuilder: ClearButtonMode {
    
    private var size: CGSize = CGSize(width: 20, height: 20)
    private var systemName: String = K.Images.xCircleFill
    
    
//  MARK: - INITIALIAZERS
    
    private weak var textFieldBuilder: TextFieldBuilder?
    
    init(textFieldBuilder: TextFieldBuilder? = nil) {
        self.textFieldBuilder = textFieldBuilder
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setSizeButton(_ size: CGSize) -> Self {
        self.size = size
        return self
    }
    
    @discardableResult
    public func setImgButton(_ systemName: String) -> Self {
        self.systemName = systemName
        return self
    }
    
    
//  MARK: - APPLY
    public func apply() -> Self {
        textFieldBuilder?.get.clearButtonMode = .whileEditing
        let button = createClearButtonView(size, systemName)
        textFieldBuilder?.setPadding(button, .right, .whileEditing)
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    private func createClearButtonView(_ size: CGSize, _ imgSystemName: String) -> ViewBuilder {
        let view = ViewBuilder(frame: CGRect(x: 0, y: 0, width: size.width + 10, height: size.height))
        
        let img = ImageViewBuilder(systemName: imgSystemName)
            .setSize(22)
            .setContentMode(.center)
        
        let clearButton = ButtonImageBuilder(frame: CGRect(x: 0, y: 0, width: size.width + 10, height: size.height))
            .setImageButton(img)
        
        
//        let clearButton = UIButton(type: .custom)
//        clearButton.setImage(UIImage(systemName: imgSystemName), for: .normal)
//        clearButton.frame = CGRect(origin: .zero, size: size)
        clearButton.get.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        view.get.addSubview(clearButton.get)
        
        return view
    }
    
    
//  MARK: - @OBJC FUNCTION AREA
    @objc
    private func clearButtonTapped() {
        textFieldBuilder?.setText("")
    }
    
}
