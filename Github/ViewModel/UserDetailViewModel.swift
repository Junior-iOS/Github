//
//  UserDetailViewModel.swift
//  Github
//
//  Created by NJ Development on 26/05/23.
//

import Foundation
import UIKit

protocol UserDetailViewModelDelegate: AnyObject {
    func handleSuccess(with userDetail: UserDetail)
    func didNotLoadRepos(_ error: NetworkError)
}

final class UserDetailViewModel: NSObject {
    private let service: NetworkProviderProtocol
    weak var delegate: UserDetailViewModelDelegate?
    
    init(service: NetworkProviderProtocol = NetworkProvider()) {
        self.service = service
    }
    
    func fetchDetail(_ user: User) {
        guard let userDetail = user.detail,
              let url = URL(string: userDetail) else { return }
        let resource = Resource<UserDetail>(url: url)
        
        service.load(resource: resource) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let detail):
                self.delegate?.handleSuccess(with: detail)
            case .failure(let error):
                delegate?.didNotLoadRepos(error)
            }
        }
    }
}

