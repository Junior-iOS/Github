//
//  UserListViewController.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import UIKit

class UserListViewController: UIViewController {
    
    // MARK: - Properties
    let userView = UserListView()
    let viewModel: UserListViewModel
    
    var user: User?

    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.view = userView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    init(viewModel: UserListViewModel = UserListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Users"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        viewModel.fetchUsers(.searchList())
    }
    
    private func setupTable() {
        userView.tableView.delegate = self
        userView.tableView.dataSource = self
    }
}

// MARK: - UITableView Delegate and Datasource
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let user = viewModel.users?[indexPath.row] else { return }
        self.user = user
        viewModel.fetchDetail(user)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(of: UserListTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self, let user = viewModel.users?[indexPath.row] else { return }
            cell.configure(user: user)
        }
    }
}

// MARK: - UserViewModel Delegate
extension UserListViewController: UserListViewModelDelegate {
    func didLoadList() {
        userView.tableView.reloadData()
        userView.spinner.stopAnimating()
    }
    
    func didNotLoadList(_ error: NetworkError) {
        AlertManager.show(error, from: self)
    }
    
    func didSelectUser(_ userDetail: UserDetail?) {
        let vc = UserDetailViewController()
        vc.user = self.user
        vc.userDetail = userDetail
        navigationController?.pushViewController(vc, animated: true)
    }
}
