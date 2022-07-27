//
//  SceneDelegate.swift
//  NaviAssignment
//
//  Created by Athul Sai on 21/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appFlowCoordinator: AppFlowCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.frame = UIScreen.main.bounds

        appFlowCoordinator = AppFlowCoordinator(appDependencyContainer: AppDependencyContainer())
        window?.rootViewController = appFlowCoordinator.navigationController
        window?.makeKeyAndVisible()

        appFlowCoordinator.start()
    }
}

