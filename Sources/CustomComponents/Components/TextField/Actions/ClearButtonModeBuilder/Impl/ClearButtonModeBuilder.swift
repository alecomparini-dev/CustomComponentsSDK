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
        textFieldBuilder?.setPadding(createClearButtonView(size, systemName), .right, .whileEditing)
        return self
    }
    
    
//  MARK: - PRIVATE AREA
    private func createClearButtonView(_ size: CGSize, _ imgSystemName: String) -> ViewBuilder {
        let frame = CGRect(x: 0, y: 0, width: size.width + 10, height: size.height)
        let view = ViewBuilder(frame: frame)
        
        let img = ImageViewBuilder(systemName: imgSystemName)
            .setContentMode(.center)
            .setSize(max(size.width, size.height) * 0.75)
        
        let clearButton = ButtonImageBuilder()
            .setImageButton(img)
            .setFrame(CGRect(origin: .zero, size: size))
        
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
