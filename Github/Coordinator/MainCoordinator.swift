//
//  MainCoordinator.swift
//  Github
//
//  Created by NJ Development on 27/05/23.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let userListViewController = UserListViewController()
        userListViewController.mainCoordinator = self
        navigationController.pushViewController(userListViewController, animated: true)
    }
    
    func routToDetails(_ user: User) {
        let vc = UserDetailViewController()
        vc.mainCoordinator = self
        vc.user = user
        navigationController.pushViewController(vc, animated: true)
    }
    
    func routeToRepos(_ repos: String) {
        let vc = RepositoriesViewController()
        vc.mainCoordinator = self
        vc.reposURL = repos
        navigationController.pushViewController(vc, animated: true)
    }
}
