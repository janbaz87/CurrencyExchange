//
//  AppCoordinator.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import UIKit

final class AppRouter {

    private let window: UIWindow? // Router for the initial VIPER module

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        guard let window = window else { return }
        ExchangeRatesRouter().showExchageRatesView(on: window)
    }

}
