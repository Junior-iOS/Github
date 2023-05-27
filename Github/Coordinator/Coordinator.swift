//
//  Coordinator.swift
//  Github
//
//  Created by NJ Development on 26/05/23.
//

import Foundation
import UIKit

// MARK: - Coordinator
protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
