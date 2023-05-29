//
//  RepositoriesViewController.swift
//  Github
//
//  Created by NJ Development on 26/05/23.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    private let repoView = RepositoriesView()
    private let viewModel: RepositoriesViewModel
    var reposURL = ""
    
    weak var mainCoordinator: MainCoordinator?
    
    override func loadView() {
        super.loadView()
        self.view = repoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTable()
        viewModel.fetchRepos(from: reposURL)
    }
    
    init(viewModel: RepositoriesViewModel = RepositoriesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        defaultBackButton()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Repositories"
    }
    
    private func setupTable() {
        repoView.tableView.delegate = self
        repoView.tableView.dataSource = self
    }
}

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(of: RepositoriesTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self,
                  let repos = viewModel.repos?[indexPath.row] else { return }
            cell.configure(viewModel: repos)
        }
    }
}

// MARK: - Repositories Delegate
extension RepositoriesViewController: RepositoriesDelegate {
    func didLoadRepos() {
        repoView.spinner.stopAnimating()
        repoView.tableView.reloadData()
    }
    
    func didNotLoadRepos(_ error: NetworkError) {
        showAlert(message: error)
    }
}
