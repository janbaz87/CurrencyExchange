//
//  SceneDelegate.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 02/11/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appRouter: AppRouter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        appRouter = AppRouter(window: window)
        appRouter?.start()
    }

}

