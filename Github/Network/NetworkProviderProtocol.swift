//
//  NetworkProviderProtocol.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import Foundation

protocol NetworkProviderProtocol: AnyObject {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void)
}
