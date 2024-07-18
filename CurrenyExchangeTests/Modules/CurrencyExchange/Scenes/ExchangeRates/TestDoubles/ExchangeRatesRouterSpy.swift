//
//  ExchangeRatesRouterSpy.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 09/11/2023.
//

import UIKit
@testable import CurrenyExchange

class ExchangeRatesRouterSpy: ExchangeRatesRouting {
    func showExchageRatesView(on window: UIWindow) {
        showExchageRatesCalled = true
    }

    func presentCurrencyList(with selectionHandler: @escaping (CurrenyExchange.Currency?) -> Void) {
        presentCurrencyListCalled = true
    }

    var presentCurrencyListCalled = false
    var showExchageRatesCalled = false
}
