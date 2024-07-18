//
//  CurrencyExchangeEndpoint.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 02/11/2023.
//

enum CurrencyExchangeEndpoint {
    case exchageRates
    case currenciesList
}

extension CurrencyExchangeEndpoint {
    var path: String {
        switch self {
        case .exchageRates:
            return "latest.json"
        case .currenciesList:
            return "currencies.json"
        }
    }
}
