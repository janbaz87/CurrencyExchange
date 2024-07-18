//
//  CurrencyExchangeRepository.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 05/11/2023.
//

import Foundation

protocol CurrencyExchangeRepositoryProviding {
    func fetchCurrencies() async -> Currencies?
    func fetchExchangeRates(for currency: String?, amount: Double?) async -> ExchangeRates?
}

final class CurrencyExchangeRepository: CurrencyExchangeRepositoryProviding {

    // MArk: - Properties
    private let service: CurrrencyServiceProviding
    private let localStore: CurrenciesDataStorage
    private let dataSourceDecisionMaker: DataSourceDecisionMaking
    private let currencyConverter: CurrencyConvertable

    // MARK: - Internal
    init(
        service: CurrrencyServiceProviding,
        localStore: CurrenciesDataStorage,
        dataSourceDecisionMaker: DataSourceDecisionMaking,
        currencyConverter: CurrencyConvertable
    ) {
        self.service = service
        self.localStore = localStore
        self.dataSourceDecisionMaker = dataSourceDecisionMaker
        self.currencyConverter = currencyConverter
    }

    func fetchCurrencies() async -> Currencies? {
        let dataSource = getDateSourceForCurrencies()
        switch dataSource {

        case .local:
            return getCurrenciesFromLocalStore()
        case .remote:
            await loadCurrenciesFromServer()
            return getCurrenciesFromLocalStore()
        }
    }

    func fetchExchangeRates(for currency: String?, amount: Double?) async -> ExchangeRates? {
        let dataSource = getDateSource()
        switch dataSource {

        case .local:
            return getExchageRatesFromLocalStore(for: amount, and: currency)
        case .remote:
            await loadExchangeRatesFromServer()
            return getExchageRatesFromLocalStore(for: amount, and: currency)
        }
    }

    // MARK: - Private

    private func getDateSource() -> DataSource {
        let lastFetchedTime = localStore.getLastFetchedTime()
        return dataSourceDecisionMaker.getDataSource(with: lastFetchedTime)
    }

    private func getDateSourceForCurrencies() -> DataSource {
        guard (localStore.getCurrenciesList() != nil) else {
            return .remote
        }
        let lastFetchedTime = localStore.getLastFetchedTime()
        return dataSourceDecisionMaker.getDataSource(with: lastFetchedTime)
    }
}

// MARK: - Save time
private extension CurrencyExchangeRepository {

    private func updateLastFetchedTime() {
        localStore.storeLastFetchedTime(date: Date())
    }

}

// MARK: -  Currencies exchange rates handling
private extension CurrencyExchangeRepository {

    func loadExchangeRatesFromServer() async {
        let result = await service.fetchCurrencyExchangeRates()

        switch result {
        case .success(let exchangeRates):
            guard let exchangeRates = exchangeRates else { return }
            updateLastFetchedTime()
            handleExchangeRatesResponseFromServer(exchangeRates: exchangeRates)
        case .failure(_):
           break
        }
    }

    func handleExchangeRatesResponseFromServer(exchangeRates: CurrencyExchangeRateResponse) {
        localStore.storeExchageRates(rates: exchangeRates)
    }

    func getExchageRatesFromLocalStore(
        for amount: Double?,
        and currency: String?
    ) -> ExchangeRates? {
        guard let exchageRates = localStore.getExchangeRates() else { return nil }

        if currency == Constants.defaultCurrency && amount == 1 {
            return ExchangeRates(with: exchageRates)
        }

        guard let currency = currency, let amount = amount else { return nil }

        let convertedRates = currencyConverter.convertAmount(
            amount: amount,
            with: Constants.defaultCurrency,
            to: currency,
            from: exchageRates.rates
        )

        return ExchangeRates(with: currency, exchageRates: convertedRates)
    }

    enum Constants {
        static let defaultCurrency = "USD"
        static let defaultAmount = 1.0
    }
}

// MARK: -  Currencies List Handling
private extension CurrencyExchangeRepository {

    private func loadCurrenciesFromServer() async {
        let result = await service.fetchCurrenciesList()

        switch result {
        case .success(let currencies):
            guard let currencies = currencies else { return }
            handleCurrenciesResponseFromServer(currencies: currencies)
        case .failure(_):
            break
        }
    }

    private func handleCurrenciesResponseFromServer(currencies: CurrencyListResponse) {
        localStore.storeCurreniesList(currencies: currencies)
    }

    private func getCurrenciesFromLocalStore() -> Currencies? {
        guard let currencies = localStore.getCurrenciesList() else { return nil }
        return Currencies(with: currencies)
    }
}

