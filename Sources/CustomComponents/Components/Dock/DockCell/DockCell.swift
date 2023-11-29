//  Created by Alessandro Comparini on 29/11/23.
//

import UIKit

class DockCell: UICollectionViewCell {
    static let identifier: String = String(describing: DockCell.self)
    
    private var isUserInteraction: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ view: UIView) {
        removeSubViews(contentView)
        view.add(insideTo: self.contentView)
        view.makeConstraints { make in
            make
                .setPin.equalToSuperView
                .apply()
        }
    }
    
    private func removeSubViews(_ view: UIView) {
        view.subviews.forEach { $0.removeFromSuperview() }
    }
    
}
