//
//  ExchangeRatesInteractorStub.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 09/11/2023.
//

@testable import CurrenyExchange

class ExchangeRatesInteractorStub: ExchangeRatesInteractorInputing {
    @MainActor
    func fetchExchangeRates(for currency: String?, amount: Double?) {
        fetchExchangeRatesCalled = true
        output?.successfullyFetchedExchangeRates(exchageRates: Mocks.exchangeRates)
    }

    var fetchExchangeRatesCalled = false
    var output: ExchangeRatesInteractorOutputing?
}
