//
//  UserDetailViewController.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User?
    var userDetail: UserDetail?
    private lazy var userDetailView = UserDetailView(user: user, userDetail: userDetail)
    private let viewModel: UserDetailViewModel
    
    override func loadView() {
        super.loadView()
        self.view = userDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    init(viewModel: UserDetailViewModel = UserDetailViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        view.backgroundColor = .secondarySystemBackground
        defaultBackButton()
        userDetailView.delegate = self
    }
}

// MARK: - UserDetailView Delegate
extension UserDetailViewController: UserDetailViewDelegate {
    func didTapSeeRepos(from user: User) {
        viewModel.fetchRepos(from: user)
    }
}

// MARK: - UserDetailViewModel Delegate
extension UserDetailViewController: UserDetailViewModelDelegate {
    func didSelect(_ repos: [Repository]) {
        let vc = RepositoriesViewController()
        vc.repos = repos
        navigationController?.pushViewController(vc, animated: true)
    }
}
