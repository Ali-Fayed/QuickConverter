//
//  SceneDelegate.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 23/02/2023.
//
import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let navigationController = UINavigationController()
    var coordinator: AppCoordinator?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        initAppCoordinator(scene: scene)
    }
    func initAppCoordinator(scene: UIWindowScene) {
        coordinator = AppCoordinator(navigationController: navigationController)
         let window = UIWindow(windowScene: scene)
         window.rootViewController = navigationController
         window.makeKeyAndVisible()
         self.window = window
         coordinator?.start()
    }
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
