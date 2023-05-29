//
//  UserDetailViewController.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User?
    
    private lazy var userDetailView = UserDetailView(user: user)
    private let viewModel: UserDetailViewModel
    
    weak var mainCoordinator: MainCoordinator?
    
    override func loadView() {
        super.loadView()
        self.view = userDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        guard let user = user else { return }
        viewModel.fetchDetail(user)
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
        navigationItem.title = "Details"
        defaultBackButton()
        userDetailView.delegate = self
    }
}

// MARK: - UserDetailView Delegate
extension UserDetailViewController: UserDetailViewDelegate {
    func didTapSeeRepos(from user: User) {
        mainCoordinator?.routeToRepos(user.repos ?? "")
    }
}

// MARK: - UserDetailViewModel Delegate
extension UserDetailViewController: UserDetailViewModelDelegate {
    func handleSuccess(with userDetail: UserDetail) {
        userDetailView.configureView(userDetail)
    }
    
    func didNotLoadRepos(_ error: NetworkError) {
        showAlert(message: error)
    }
}
