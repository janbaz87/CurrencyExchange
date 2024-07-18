//
//  ExchangeRatesPresenterSpy.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 09/11/2023.
//

@testable import CurrenyExchange

class ExchangeRatesPresenterSpy: ExchangeRatesInteractorOutputing {
    func successfullyFetchedExchangeRates(exchageRates: CurrenyExchange.ExchangeRates?) {
        fetchExchangeRatesCalled = true
    }
    var fetchExchangeRatesCalled = false

}

extension ExchangeRatesPresenterSpy: ExchangeRatesPresentation {
    func viewDidLoad() {

    }

    func selectCurrencyTapped() {

    }

    func doneTappedWith(currency: String?, amount: String?) {

    }

}
