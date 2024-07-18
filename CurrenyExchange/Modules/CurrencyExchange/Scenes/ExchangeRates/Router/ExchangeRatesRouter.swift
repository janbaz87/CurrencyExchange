//
//  ExchangeRatesRouter.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import UIKit

protocol ExchangeRatesRouting {
    func showExchageRatesView(on window: UIWindow)
    func presentCurrencyList(with selectionHandler: @escaping (Currency?) -> Void)
}

final class ExchangeRatesRouter: ExchangeRatesRouting {
    
    // MARK: - Private
    private weak var viewController: UIViewController?
    private var root: UINavigationController?
    private let builer: ExchangeRatesBuildable
    private let currenciesListRouter: CurrenciesListRouting

    // MARK: - Init
    init(
        builder: ExchangeRatesBuildable = ExchangeRatesBuilder(),
        currenciesListRouter: CurrenciesListRouting = CurrenciesListRouter()
    ) {
        self.builer = builder
        self.currenciesListRouter = currenciesListRouter
    }

    // MARK: - Internal
    func showExchageRatesView(on window: UIWindow) {
        viewController = builer.buildExchangeRates(router: self)
        guard let viewController = viewController else { return }
        root = UINavigationController(rootViewController: viewController)
        window.rootViewController = root
        window.makeKeyAndVisible()
    }

    func presentCurrencyList(with selectionHandler: @escaping (Currency?) -> Void) {
        currenciesListRouter.presentCurrenciesList(from: viewController, selectionHandler: selectionHandler)
    }
}
