//
//  Bundle+Extensions.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import Foundation

extension Bundle {
    var host: String {
        object(forInfoDictionaryKey: "HOST") as? String ?? ""
    }
    
    var scheme: String {
        object(forInfoDictionaryKey: "SCHEME") as? String ?? ""
    }
    
    var endpoint: String {
        object(forInfoDictionaryKey: "ENDPOINT") as? String ?? ""
    }
}
