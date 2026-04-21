//
//  SceneDelegate.swift
//  CathaysecTestDemo1
//
//  Created by Giles on 2026/4/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
                // 1. 建立一個與螢幕大小相同的 Window
                let window = UIWindow(windowScene: windowScene)
                
                // 2. 依賴注入 (組裝我們的 Clean Architecture)
                // 由底層一路往上組裝：UseCase -> ViewModel -> ViewController
        let useCase = DefaultFetchAppServicesUseCase() 
        let viewModel = MyAccountViewModel(useCase: useCase)
        let viewController = MyAccountViewController(viewModel: viewModel)
                
                // 如果你希望上方有 Navigation Bar (導覽列)，可以包一層 UINavigationController
                let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.navigationBar.topItem?.title = "Live Coding" // 設定標題
                
                // 3. 將剛剛組裝好的 ViewController 設定為 App 的初始首頁
                window.rootViewController = navigationController
                
                // 4. 顯示畫面
                self.window = window
                window.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
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

