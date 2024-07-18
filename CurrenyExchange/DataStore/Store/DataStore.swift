//
//  DataStore.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 04/11/2023.
//

import Foundation

enum UserDefaultsKey {
    static let currencies = "currencies"
    static let exchangeRate = "exchange_rates"
    static let lastFetchedTime = "last_fetched_time"
}

class UserDefaultsDataStore: CurrenciesDataStorage {

    // MARK: - Init
    init (with userdefaultsWrapper: UserDefaultsWrapping) {
        self.userdefaultsWrapper = userdefaultsWrapper
    }

    // MARK: - Currency
    func storeCurreniesList(currencies: CurrencyListResponse) {
        userdefaultsWrapper.save(currencies, forKey: UserDefaultsKey.currencies)
    }

    func getCurrenciesList() -> CurrencyListResponse? {
        userdefaultsWrapper.load(forKey:  UserDefaultsKey.currencies)
    }

    // MARK: - Exchange rates
    func storeExchageRates(rates: CurrencyExchangeRateResponse) {
        userdefaultsWrapper.save(rates, forKey: UserDefaultsKey.exchangeRate)
    }

    func getExchangeRates() -> CurrencyExchangeRateResponse? {
        userdefaultsWrapper.load(forKey:  UserDefaultsKey.exchangeRate)
    }

    // MARK: - Time
    func getLastFetchedTime() -> Date? {
        userdefaultsWrapper.loadDate(forKey: UserDefaultsKey.lastFetchedTime)
    }

    func storeLastFetchedTime(date: Date = Date()) {
        userdefaultsWrapper.saveDate(date: date, forKey: UserDefaultsKey.lastFetchedTime)
    }

    // MARK: - Private

    private let userdefaultsWrapper: UserDefaultsWrapping

}
