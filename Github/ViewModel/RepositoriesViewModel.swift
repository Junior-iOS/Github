//
//  RepositoriesViewModel.swift
//  Github
//
//  Created by NJ Development on 28/05/23.
//

import Foundation
import UIKit

protocol RepositoriesDelegate: AnyObject {
    func didLoadRepos()
    func didNotLoadRepos(_ error: NetworkError)
}

final class RepositoriesViewModel: NSObject {
    
    private let service: NetworkProviderProtocol
    weak var delegate: RepositoriesDelegate?
    
    var repos: [Repository]?
    
    init(service: NetworkProviderProtocol = NetworkProvider()) {
        self.service = service
    }
    
    func fetchRepos(from repos: String) {
        guard let url = URL(string: repos) else { return }
        let resource = Resource<[Repository]>(url: url)
        
        service.load(resource: resource) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let repos):
                self.repos = repos
                delegate?.didLoadRepos()
            case .failure(let error):
                delegate?.didNotLoadRepos(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return repos?.count ?? 0
    }
}
