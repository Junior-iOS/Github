//
//  UserListTableViewCell.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import UIKit
import SDWebImage

class UserListTableViewCell: UITableViewCell {

    // MARK: - Properties
    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.addShadow()
        return view
    }()
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = .kImageSize / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [userImage, loginLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()

    // MARK: - Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = nil
        loginLabel.text = nil
    }

    private func setupCell() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(hStack)

        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .kMargins),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .kMargins),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.kMargins),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.kMargins),

            hStack.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: .kMargins),
            hStack.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: .kMargins),
            hStack.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -.kMargins),
            hStack.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -.kMargins),
            
            userImage.heightAnchor.constraint(equalToConstant: .kImageSize),
            userImage.widthAnchor.constraint(equalToConstant: .kImageSize)
        ])
    }

    func configure(user: User?) {
        guard let user,
              let login = user.login,
              let avatar = user.avatar,
              let url = URL(string: avatar) else { return }
        
        self.userImage.sd_setImage(with: url)
        self.loginLabel.text = login
    }
}

// MARK: - Constants
fileprivate extension CGFloat {
    static let kMargins: CGFloat = 10
    static let kLabelHeight: CGFloat = 20
    static let kImageSize: CGFloat = 50
}
