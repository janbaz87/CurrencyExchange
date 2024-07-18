//
//  CurrencyExchangeRepositoryStub.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

import Foundation
@testable import CurrenyExchange

class CurrencyExchangeRepositoryStub: CurrencyExchangeRepositoryProviding {
    var fetchCurrenciesCalled = false
    var fetchExchangeRatesCalled = false

    func fetchCurrencies() async -> Currencies? {
        fetchCurrenciesCalled = true
        return Mocks.currenciesObject
    }

    func fetchExchangeRates(for currency: String?, amount: Double?) async -> ExchangeRates? {
        fetchExchangeRatesCalled = true
        return Mocks.exchangeRates
    }
}
