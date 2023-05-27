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
    
    func routToDetails(_ user: User, with detail: UserDetail) {
        let vc = UserDetailViewController()
        vc.mainCoordinator = self
        vc.user = user
        vc.userDetail = detail
        navigationController.pushViewController(vc, animated: true)
    }
    
    func routeToRepos(_ repos: [Repository]) {
        let vc = RepositoriesViewController()
        vc.mainCoordinator = self
        vc.repos = repos
        navigationController.pushViewController(vc, animated: true)
    }
}
