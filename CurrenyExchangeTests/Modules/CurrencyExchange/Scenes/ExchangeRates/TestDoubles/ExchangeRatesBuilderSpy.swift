//
//  ExchangeRatesBuilderSpy.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 09/11/2023.
//

@testable import CurrenyExchange

class ExchangeRatesBuilderSpy: ExchangeRatesBuildable {
    
    func buildExchangeRates(router: CurrenyExchange.ExchangeRatesRouting) -> ExchangeRatesViewController {
        buildExchangeRatesCalled = true
        return ExchangeRatesViewController(presenter: ExchangeRatesPresenterSpy())
    }

    var buildExchangeRatesCalled = false

}
