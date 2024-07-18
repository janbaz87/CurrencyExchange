//
//  CurrenciesListInteractor.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 06/11/2023.
//

import UIKit

protocol CurrenciesListInteractorInputing {
    func fetchCurrenciesList()
}

protocol CurrenciesListInteractorOutputing: AnyObject {
    @MainActor
    func successfullyFetchedCurrencies(currencies: Currencies?)
}

final class CurrenciesListInteractor: CurrenciesListInteractorInputing {

    // MARK: - Init
    init(repository: CurrencyExchangeRepositoryProviding) {
        self.repository = repository
    }

    // MARK: - Internal
    weak var output: CurrenciesListInteractorOutputing?

    func fetchCurrenciesList() {
        Task { [weak self] in
            let currencies = await self?.repository.fetchCurrencies()
            await self?.output?.successfullyFetchedCurrencies(currencies: currencies)
        }
    }

    // MARK: - Private
    private let repository: CurrencyExchangeRepositoryProviding

}
