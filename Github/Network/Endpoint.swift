//
//  GithubEndpoint.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import Foundation
import UIKit

struct Endpoint {
    let path: String
    let method: String

    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Bundle.main.scheme
        urlComponents.host = Bundle.main.host
        urlComponents.path = path
        return urlComponents.url
    }
}

extension Endpoint {
    static func searchList() -> Self {
        Self(path: Bundle.main.endpoint, method: "GET")
    }
}
