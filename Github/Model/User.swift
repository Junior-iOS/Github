//
//  User.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import Foundation
import UIKit

struct User: Codable {
    let login: String?
    let avatar: String?
    let detail: String?
    let repos: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatar = "avatar_url"
        case detail = "url"
        case repos = "repos_url"
    }
}
