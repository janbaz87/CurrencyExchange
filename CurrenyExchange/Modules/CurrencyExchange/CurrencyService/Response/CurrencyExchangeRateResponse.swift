//
//  CurrencyExchangeRateResponse.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 03/11/2023.
//

struct CurrencyExchangeRateResponse: Codable, Equatable {
    let base: String
    let rates: [String : Double]

    // MARK: - Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rates == rhs.rates
    }

    static var mock: CurrencyExchangeRateResponse {
        CurrencyExchangeRateResponse(base: "USA", rates: ["PKR": 285])
    }
}
