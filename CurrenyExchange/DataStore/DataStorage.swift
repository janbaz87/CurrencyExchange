//
//  DataStorage.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 04/11/2023.
//

import Foundation

protocol CurrenciesDataStorage {
    func storeCurreniesList(currencies: CurrencyListResponse)
    func getCurrenciesList() -> CurrencyListResponse?
    func storeExchageRates(rates: CurrencyExchangeRateResponse)
    func getExchangeRates() -> CurrencyExchangeRateResponse?
    func getLastFetchedTime() -> Date?
    func storeLastFetchedTime(date: Date)
}
