//
//  CurrencyListResponse.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 02/11/2023.
//

import Foundation

struct CurrencyListResponse: Codable, Equatable {
    let currencies: [String: String]

    // MARK: - Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.currencies == rhs.currencies
    }

    static var mock: CurrencyListResponse {
        CurrencyListResponse(currencies: ["USA":"United States Dollar"])
    }
}
