//  Created by Alessandro Comparini on 22/02/24.
//

import UIKit

public class IconButtonBuilder: ButtonImageBuilder {
    
    override init(_ image: ImageViewBuilder) {
        super.init(image)
        if #available(iOS 15.0, *) {
            configure()
        }
    }

    convenience init(_ image: ImageViewBuilder, _ title: String) {
        self.init(image)
        _ = setTitle(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(iOS 15.0, *)
    private func configure() {
        _ = super.setImagePlacement(.top)
    }

    
//  MARK: - Set
    
    public override func setImagePlacement(_ alignment: NSDirectionalRectEdge) -> Self {
        print("It is not possible to change the alignment of the image on the Icon Button")
        return self
    }
    
    public override func setTitleAlignment(_ alignment: K.Text.ContentHorizontalAlignment?) -> Self {
        print("It is not possible to change the title alignment on the Icon Button, will ever center")
        return self
    }
    
    
}
