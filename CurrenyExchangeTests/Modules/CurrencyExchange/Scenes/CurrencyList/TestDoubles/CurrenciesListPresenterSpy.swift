//
//  CurrenciesListPresenterSpy.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

@testable import CurrenyExchange

class CurrenciesListPresenterSpy: CurrenciesListInteractorOutputing {

    @MainActor
    func successfullyFetchedCurrencies(currencies: CurrenyExchange.Currencies?) {
        fetchCurrenciesCalled = true
    }

    var fetchCurrenciesCalled = false

}

extension CurrenciesListPresenterSpy: CurrenciesListPresentation {
    func viewDidLoad() {

    }

    func didSelect(currency selectedCurrency: CurrenyExchange.Currency?) {

    }
}
