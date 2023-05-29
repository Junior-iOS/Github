//
//  UserListViewModel.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import Foundation
import UIKit

protocol UserListViewModelDelegate: AnyObject {
    func didLoadList()
    func didNotLoadList(_ error: NetworkError)
}

final class UserListViewModel: NSObject {
    private let service: NetworkProviderProtocol
    weak var delegate: UserListViewModelDelegate?
    
    var users: [User]? {
        didSet {
            self.delegate?.didLoadList()
        }
    }

    init(service: NetworkProviderProtocol = NetworkProvider()) {
        self.service = service
    }
    
    func fetchUsers(_ endpoint: Endpoint) {
        guard let url = endpoint.url else { return }
        let resource = Resource<[User]>(url: url)
        
        service.load(resource: resource) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                delegate?.didNotLoadList(error)
            }
        }
    }
    
    func didSelectUserAt(index: Int) -> User? {
        return users?[index]
    }
    
    func numberOfRows() -> Int {
        return users?.count ?? 0
    }
}

