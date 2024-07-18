//
//  ExchangeRatesViewSpy.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 09/11/2023.
//

@testable import CurrenyExchange

class ExchangeRatesViewSpy: ExchangeRatesView {
    func setExchangeRatesData(exchangeRates: [CurrenyExchange.Rate]) {
        setExchangeRatesCalled = true
    }

    func setBaseCurrency(currency: String) {

    }

    func newCurrencySelected(currency: String) {

    }

    var setExchangeRatesCalled = false

}
