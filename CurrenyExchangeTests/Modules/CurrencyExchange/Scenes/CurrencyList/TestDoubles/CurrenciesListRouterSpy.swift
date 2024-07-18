//
//  CurrenciesListRouterSpy.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//
import UIKit
@testable import CurrenyExchange

class CurrenciesListRouterSpy: CurrenciesListRouting {
    
    func presentCurrenciesList(from sourceViewController: UIViewController?, selectionHandler: @escaping (CurrenyExchange.Currency?) -> Void) {
        presentCurrenciesListCalled = true
    }

    func dismiss() {
        dimissCalled = true
    }

    var dimissCalled = false
    var presentCurrenciesListCalled = false
}
