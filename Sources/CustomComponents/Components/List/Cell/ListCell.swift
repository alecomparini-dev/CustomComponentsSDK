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
//        view.add(insideTo: contentView)
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.makeConstraints { make in
//            make
//                .setPin.equalToSuperview
//                .apply()
//        }
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: super.topAnchor),
            view.bottomAnchor.constraint(equalTo: super.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: super.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: super.trailingAnchor),
        ])
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        selectionStyle = .none
        backgroundColor = .clear
        removeSubViews(contentView)
    }
    
    private func removeSubViews(_ view: UIView) {
        view.subviews.forEach { $0.removeFromSuperview() }
    }
    
}
