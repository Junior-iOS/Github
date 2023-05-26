//
//  RepositoriesViewController.swift
//  Github
//
//  Created by NJ Development on 26/05/23.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    var repos: [Repository] = [Repository]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        for repo in repos {
            print(repo)
            print("\n")
        }
    }
}
