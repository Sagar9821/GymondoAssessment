//
//  SceneDelegate.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigator: Navigator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navController = UINavigationController()
        navigator = Navigator(navigationController: navController)
        navigator?.startUserFlow(with: .exerciseList)
        let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navController
            self.window = window
            window.makeKeyAndVisible()
    }

}

