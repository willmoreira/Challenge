//
//  SceneDelegate.swift
//  Challenge
//
//  Created by William on 14/07/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let viewCoordinator = ListCharactersCoordinator()
            let viewController = viewCoordinator.start()
            let navigationController = UINavigationController(rootViewController: viewController)
            viewCoordinator.navigationController = navigationController
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
