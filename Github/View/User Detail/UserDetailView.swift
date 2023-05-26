//
//  UserDetailview.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import UIKit
import SDWebImage

protocol UserDetailViewDelegate: AnyObject {
    func didTapSeeRepos(from user: User)
}

class UserDetailView: UIView {
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = .kImageSize / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        return imageView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.addShadow()
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameLoginVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, loginLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Followers"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followersCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followersVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followersLabel, followersCountLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Following"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followingLabel, followingCountLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private lazy var publicRepoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Repos"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var publicReposCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var publicReposVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [publicRepoLabel, publicReposCountLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private lazy var followHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followersVStack, followingVStack, publicReposVStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLoginVStack, followHStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()

    private lazy var reposButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See repos", for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = .kButtonHeight / 2
        button.addTarget(self, action: #selector(seeReposButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var user: User?
    var userDetail: UserDetail?
    weak var delegate: UserDetailViewDelegate?

    init(user: User?, userDetail: UserDetail?) {
        super.init(frame: .zero)
        self.user = user
        self.userDetail = userDetail
        
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        addSubviews(backgroundView, userImage)
        backgroundView.addSubviews(mainVStack,
                                   reposButton)

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: .kScreenHeight / 2),
            
            userImage.widthAnchor.constraint(equalToConstant: .kImageSize),
            userImage.heightAnchor.constraint(equalToConstant: .kImageSize),
            userImage.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            userImage.bottomAnchor.constraint(equalTo: backgroundView.topAnchor, constant: .kMargin),
            
            mainVStack.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: .kButtonHeight),
            mainVStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: .kMargin),
            mainVStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -.kMargin),
            mainVStack.bottomAnchor.constraint(equalTo: reposButton.topAnchor, constant: -.kButtonHeight),
            
            nameLabel.heightAnchor.constraint(equalToConstant: .kMargin),
            followersLabel.heightAnchor.constraint(equalToConstant: .kLabelHeight),
            followingLabel.heightAnchor.constraint(equalToConstant: .kLabelHeight),
            publicRepoLabel.heightAnchor.constraint(equalToConstant: .kLabelHeight),
            
            reposButton.leadingAnchor.constraint(equalTo: mainVStack.leadingAnchor),
            reposButton.trailingAnchor.constraint(equalTo: mainVStack.trailingAnchor),
            reposButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -.kButtonBottomMargin),
            reposButton.heightAnchor.constraint(equalToConstant: .kButtonHeight)
        ])
        
        configureViews()
    }
    
    private func configureViews() {
        guard let image = user?.avatar,
              let url = URL(string: image),
              let name = userDetail?.name,
              let login = user?.login,
              let publicRepos = userDetail?.publicRepos,
              let followers = userDetail?.followers,
              let following = userDetail?.following else { return }
        
        DispatchQueue.main.async {
            self.userImage.sd_setImage(with: url)
            self.nameLabel.text = name
            self.loginLabel.text = login
            self.followersCountLabel.text = "\(followers)"
            self.followingCountLabel.text = "\(following)"
            self.publicReposCountLabel.text = "\(publicRepos)"
        }
    }
    
    @objc private func seeReposButtonPressed() {
        guard let user = user else { return }
        delegate?.didTapSeeRepos(from: user)
    }
}

// MARK: - Constants
fileprivate extension CGFloat {
    static let kScreenHeight: CGFloat = UIScreen.main.bounds.height
    static let kImageSize: CGFloat = 300
    static let kMargin: CGFloat = 20
    static let kButtonHeight: CGFloat = 50
    static let kButtonBottomMargin: CGFloat = 60
    static let kLabelHeight: CGFloat = 16
}
