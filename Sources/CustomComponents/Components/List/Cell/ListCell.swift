//  Created by Alessandro Comparini on 30/11/23.
//

import UIKit

class ListCell: UITableViewCell {
    static let identifier: String = String(describing: ListCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ view: UIView) {
        view.add(insideTo: contentView)
        view.makeConstraints { make in
            make
                .setPin.equalToSuperview
                .apply()
        }
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        selectionStyle = .none
        backgroundColor = .clear
        removeSubViews()
    }
    
    private func removeSubViews() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
}
