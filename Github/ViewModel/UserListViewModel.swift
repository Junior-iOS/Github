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
    func didSelectUser(_ userDetail: UserDetail?)
}

final class UserListViewModel: NSObject {
    private let service: NetworkProviderProtocol
    weak var delegate: UserListViewModelDelegate?
    
    var users: [User]? {
        didSet {
            self.delegate?.didLoadList()
        }
    }
    
    var userDetail: UserDetail?

    init(service: NetworkProviderProtocol = NetworkProvider()) {
        self.service = service
    }
    
    func fetchUsers(_ endpoint: GithubEndpoint) {
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
    
    func fetchDetail(_ user: User) {
        guard let userDetail = user.detail,
              let url = URL(string: userDetail) else { return }
        let resource = Resource<UserDetail>(url: url)
        
        service.load(resource: resource) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let detail):
                self.userDetail = detail
                self.delegate?.didSelectUser(self.userDetail)
            case .failure(let error):
                delegate?.didNotLoadList(error)
            }
        }
    }
}

