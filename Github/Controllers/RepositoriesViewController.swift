//
//  RepositoriesViewController.swift
//  Github
//
//  Created by NJ Development on 26/05/23.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    private let repoView = RepositoriesView()
    var repos: [Repository] = [Repository]()
    
    weak var mainCoordinator: MainCoordinator?
    
    override func loadView() {
        super.loadView()
        self.view = repoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTable()
    }
    
    private func setup() {
        defaultBackButton()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Repos"
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
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(of: RepositoriesTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self else { return }
            cell.configure(viewModel: repos[indexPath.row])
        }
    }
}
