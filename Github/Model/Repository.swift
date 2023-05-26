//
//  Repository.swift
//  Github
//
//  Created by NJ Development on 26/05/23.
//

import Foundation
import UIKit

struct Repository: Codable {
    let name: String?
    let description: String?
    let stars: Int?
    let forks: Int?
    let owner: Owner?
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case stars = "stargazers_count"
        case forks = "forks_count"
        case owner
    }
}

struct Owner: Codable {
    let name: String?
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
    }
}
