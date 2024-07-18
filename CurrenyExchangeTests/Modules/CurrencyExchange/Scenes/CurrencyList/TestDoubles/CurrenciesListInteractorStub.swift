//
//  CurrenciesListInteractorStub.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

@testable import CurrenyExchange

class CurrenciesListInteractorSpy: CurrenciesListInteractorInputing {

    var fetchCurrenciesCalled = false
    var output: CurrenciesListInteractorOutputing?

    @MainActor
    func fetchCurrenciesList() {
        fetchCurrenciesCalled = true
        output?.successfullyFetchedCurrencies(currencies: Mocks.currenciesObject)
    }
}
