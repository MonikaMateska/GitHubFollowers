//
//  SceneDelegate.swift
//  GitHubFollowers
//
//  Created by Monika Mateska on 9.10.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
    }
    
    func createSearchNavigationController() -> UINavigationController {
        let viewController = SearchViewController()
        viewController.title = "Search"
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    func createFavouritesNavigationController() -> UINavigationController {
        let viewController = FavouritesListViewController()
        viewController.title = "Favourites"
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        UITabBar.appearance().backgroundColor = .white.withAlphaComponent(0.5)
        
        let searchNavigationController = createSearchNavigationController()
        let favouritesNavigationController = createFavouritesNavigationController()
        tabBar.viewControllers = [searchNavigationController, favouritesNavigationController]
        
        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

