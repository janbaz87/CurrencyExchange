//
//  ExchangeRatesInteractor.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import Foundation

protocol ExchangeRatesInteractorInputing {
    func fetchExchangeRates(for currency: String?, amount: Double?)
}

protocol ExchangeRatesInteractorOutputing: AnyObject {
    @MainActor
    func successfullyFetchedExchangeRates(exchageRates: ExchangeRates?)
}

final class ExchangeRatesInteractor: ExchangeRatesInteractorInputing {

    // MARK: - Init
    init(repository: CurrencyExchangeRepositoryProviding) {
        self.repository = repository
    }
    
    // MARK: - Internal
    weak var output: ExchangeRatesInteractorOutputing?
    
    func fetchExchangeRates(for currency: String? = nil, amount: Double?) {
        Task { [weak self] in
            let exchageRates = await self?.repository.fetchExchangeRates(for: currency, amount: amount)
            await self?.output?.successfullyFetchedExchangeRates(exchageRates: exchageRates)
        }
    }

    // MARK: - Private
    private let repository: CurrencyExchangeRepositoryProviding

}
