//
//  UserDetailViewModel.swift
//  Github
//
//  Created by NJ Development on 26/05/23.
//

import Foundation
import UIKit

protocol UserDetailViewModelDelegate: AnyObject {
    func didSelect(_ repos: [Repository])
    func didNotLoadRepos(_ error: NetworkError)
}

final class UserDetailViewModel: NSObject {
    private let service: NetworkProviderProtocol
    weak var delegate: UserDetailViewModelDelegate?
    
    private var repos: [Repository]?
    
    init(service: NetworkProviderProtocol = NetworkProvider()) {
        self.service = service
    }
    
    func fetchRepos(from user: User) {
        guard let repos = user.repos, let url = URL(string: repos) else { return }
        let resource = Resource<[Repository]>(url: url)
        
        service.load(resource: resource) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let repos):
                delegate?.didSelect(repos)
            case .failure(let error):
                delegate?.didNotLoadRepos(error)
            }
        }
    }
}
