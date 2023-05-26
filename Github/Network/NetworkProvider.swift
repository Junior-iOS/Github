//
//  NetworkProvider.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
}

final class NetworkProvider: NetworkProviderProtocol {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.mappingError))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
