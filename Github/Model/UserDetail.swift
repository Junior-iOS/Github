//
//  UserDetail.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import Foundation
import UIKit

struct UserDetail: Codable {
    let name: String?
    let followers: Int?
    let following: Int?
    let publicRepos: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case followers
        case following
        case publicRepos = "public_repos"
    }
}
