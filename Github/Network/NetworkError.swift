//
//  NetworkError.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
    
    var localizedDescription: String {
        switch self {
        case .decodingError:
            return "Failed to decode data"
        case .domainError:
            return "No data"
        case .urlError:
            return "Failed to read URL"
        }
    }
}
