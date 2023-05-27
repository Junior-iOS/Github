//
//  RepositoriesTableViewCell.swift
//  Github
//
//  Created by NJ Development on 26/05/23.
//

import UIKit
import SDWebImage

class RepositoriesTableViewCell: UITableViewCell {

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
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
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
    
    private func setupCell() {
        contentView.addSubview(secureView)
        secureView.addSubviews(photoImageView, nameLabel, descriptionLabel, ownerLabel, informationView)
        informationView.addSubviews(starsImageView, starsAmountLabel, forksImageView, forksAmountLabel)
        
        NSLayoutConstraint.activate([
            secureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            secureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            secureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            secureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            photoImageView.topAnchor.constraint(equalTo: secureView.topAnchor, constant: 16),
            photoImageView.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -16),
            photoImageView.widthAnchor.constraint(equalToConstant: 40),
            photoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: secureView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            ownerLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),
            ownerLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            ownerLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),

            informationView.topAnchor.constraint(equalTo: ownerLabel.bottomAnchor, constant: 10),
            informationView.leadingAnchor.constraint(equalTo: secureView.leadingAnchor, constant: 16),
            informationView.trailingAnchor.constraint(equalTo: secureView.trailingAnchor, constant: -16),
            informationView.bottomAnchor.constraint(equalTo: secureView.bottomAnchor, constant: -16),

            starsImageView.topAnchor.constraint(equalTo: informationView.topAnchor),
            starsImageView.leadingAnchor.constraint(equalTo: informationView.leadingAnchor),
            starsImageView.widthAnchor.constraint(equalToConstant: 16),
            starsImageView.heightAnchor.constraint(equalToConstant: 16),
            starsImageView.bottomAnchor.constraint(equalTo: informationView.bottomAnchor),

            starsAmountLabel.leadingAnchor.constraint(equalTo: starsImageView.trailingAnchor, constant: 4),
            starsAmountLabel.centerYAnchor.constraint(equalTo: starsImageView.centerYAnchor, constant: 1),

            forksImageView.topAnchor.constraint(equalTo: informationView.topAnchor),
            forksImageView.leadingAnchor.constraint(equalTo: starsAmountLabel.trailingAnchor, constant: 16),
            forksImageView.widthAnchor.constraint(equalToConstant: 16),
            forksImageView.heightAnchor.constraint(equalToConstant: 16),

            forksAmountLabel.leadingAnchor.constraint(equalTo: forksImageView.trailingAnchor, constant: 4),
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
