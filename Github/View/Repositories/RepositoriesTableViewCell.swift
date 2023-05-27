//
//  RepositoriesTableViewCell.swift
//  Github
//
//  Created by NJ Development on 26/05/23.
//

import UIKit
import SDWebImage

class RepositoriesTableViewCell: UITableViewCell {

    // MARK: - Properties
    private lazy var secureView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.addShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .kMargin, weight: .medium)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .kMargin, weight: .regular)
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var informationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var starsAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .darkGray
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var forksAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .darkGray
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var forksImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fork")
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        ownerLabel.text = nil
        starsAmountLabel.text = nil
        forksAmountLabel.text = nil
    }
    
    // MARK: - Setup
    private func setupCell() {
        contentView.addSubview(secureView)
        secureView.addSubviews(photoImageView, nameLabel, descriptionLabel, ownerLabel, informationView)
        informationView.addSubviews(starsImageView, starsAmountLabel, forksImageView, forksAmountLabel)
        
        NSLayoutConstraint.activate([
            secureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .kSmallMargin),
            secureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .kMediumMargin),
            secureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.kMediumMargin),
            secureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.kSmallMargin),
            
            photoImageView.topAnchor.constraint(equalTo: secureView.topAnchor, constant: .kMargin),
            photoImageView.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -.kMargin),
            photoImageView.widthAnchor.constraint(equalToConstant: .kimageSize),
            photoImageView.heightAnchor.constraint(equalToConstant: .kimageSize),
            
            nameLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: .kSmallerMargin),
            nameLabel.leadingAnchor.constraint(equalTo: secureView.leadingAnchor, constant: .kMargin),
            nameLabel.trailingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: -.kMargin),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .kSmallMargin),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            ownerLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .kSmallMargin),
            ownerLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            ownerLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),

            informationView.topAnchor.constraint(equalTo: ownerLabel.bottomAnchor, constant: .kInfoTopMargin),
            informationView.leadingAnchor.constraint(equalTo: secureView.leadingAnchor, constant: .kMargin),
            informationView.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -.kMargin),
            informationView.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -.kMargin),

            starsImageView.topAnchor.constraint(equalTo: informationView.topAnchor),
            starsImageView.leadingAnchor.constraint(equalTo: informationView.leadingAnchor),
            starsImageView.widthAnchor.constraint(equalToConstant: .kMargin),
            starsImageView.heightAnchor.constraint(equalToConstant: .kMargin),
            starsImageView.bottomAnchor.constraint(equalTo: informationView.bottomAnchor),

            starsAmountLabel.leadingAnchor.constraint(equalTo: starsImageView.trailingAnchor, constant: .kStarForkMargin),
            starsAmountLabel.centerYAnchor.constraint(equalTo: starsImageView.centerYAnchor, constant: .kStarYAnchor),

            forksImageView.topAnchor.constraint(equalTo: informationView.topAnchor),
            forksImageView.leadingAnchor.constraint(equalTo: starsAmountLabel.trailingAnchor, constant: .kMargin),
            forksImageView.widthAnchor.constraint(equalToConstant: .kMargin),
            forksImageView.heightAnchor.constraint(equalToConstant: .kMargin),

            forksAmountLabel.leadingAnchor.constraint(equalTo: forksImageView.trailingAnchor, constant: .kStarForkMargin),
            forksAmountLabel.centerYAnchor.constraint(equalTo: forksImageView.centerYAnchor)
        ])
    }
    
    func configure(viewModel: Repository) {
        guard let ownerName = viewModel.owner?.name,
              let avatar = viewModel.owner?.avatar,
              let stars = viewModel.stars,
              let forks = viewModel.forks else { return }
        
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        ownerLabel.text = ownerName
        starsAmountLabel.text = "\(String(describing: stars))"
        forksAmountLabel.text = "\(String(describing: forks))"
        
        if let photoUrl = URL(string: avatar) {
            photoImageView.sd_setImage(with: photoUrl)
        }
    }
}

// MARK: - Constants
fileprivate extension CGFloat {
    static let kStarYAnchor: CGFloat = 1
    static let kSmallerMargin: CGFloat = 2
    static let kStarForkMargin: CGFloat = 4
    static let kSmallMargin: CGFloat = 6
    static let kMediumMargin: CGFloat = 24
    static let kInfoTopMargin: CGFloat = 10
    static let kMargin: CGFloat = 16
    static let kimageSize: CGFloat = 40
}
