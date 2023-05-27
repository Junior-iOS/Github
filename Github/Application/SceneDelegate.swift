//
//  SceneDelegate.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        mainCoordinator = MainCoordinator()
        mainCoordinator?.start()
        window.rootViewController = mainCoordinator?.navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

