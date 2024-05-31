//  Created by Alessandro Comparini on 30/11/23.
//

import UIKit

@MainActor
class ListCell: UITableViewCell {
    static let identifier: String = String(describing: ListCell.self)
    
    private var viewCell: Any?
    
    
//  MARK: - INITIALIZERS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SETUP CELL
    
    func setupCell<T>(_ view: T) {
        viewCell = view
        configure()
    }

    
//  MARK: - PRIVATE AREA
    private func configure() {
        configStyle()
        removeSubViews()
        addElement()
        configConstraints()
    }
    
    private func configStyle() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func removeSubViews() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func addElement() {
        if let viewCell = viewCell as? ViewBuilder {
            self.contentView.addSubview(viewCell.get)
        }
        
        if let viewCell = viewCell as? UIView {
            self.contentView.addSubview(viewCell)
        }
    }
    
    private func configConstraints() {
        var view: UIView?
        
        if let viewCell = viewCell as? ViewBuilder { view = viewCell.get }
        
        if let viewCell = viewCell as? UIView { view = viewCell }
        
        view?.makeConstraints { make in
            make
                .setPin.equalToSuperview
                .apply()
        }
    }
    
}
