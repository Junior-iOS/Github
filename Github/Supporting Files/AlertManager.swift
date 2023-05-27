//
//  AlertManager.swift
//  Github
//
//  Created by NJ Development on 26/05/23.
//

import Foundation
import UIKit

final class AlertManager: NSObject {
    static func show(_ error: NetworkError, from viewController: UIViewController) {
        let alert = UIAlertController(title: "Ops!", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        alert.present(viewController, animated: true)
    }
}
