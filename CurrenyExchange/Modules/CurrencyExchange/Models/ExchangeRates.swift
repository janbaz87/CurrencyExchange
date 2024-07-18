//
//  ExchangeRates.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 05/11/2023.
//

import Foundation

struct Rate: Comparable, Hashable {
    let code: String
    let rate: String

    // MARK: - Init
    init(code: String, rate: String) {
        self.code = code
        self.rate = rate
    }

    // MARK: - Comparable
    static func < (lhs: Rate, rhs: Rate) -> Bool {
        lhs.code < rhs.code
    }

    // MARK: - Hashable
    static func == (lhs: Rate, rhs: Rate) -> Bool {
        lhs.code == rhs.code &&
        lhs.rate == rhs.rate
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
        hasher.combine(rate)
    }
}

struct ExchangeRates {
    let base: String
    var rates: [Rate] = []

    // MARK: - Init
    init(base: String, rates: [Rate]) {
        self.base = base
        self.rates = rates
    }
}

extension ExchangeRates {

    // MARK: - Init
    init(with exchageRatesResponse: CurrencyExchangeRateResponse) {
        base = exchageRatesResponse.base

        for (code, rate) in exchageRatesResponse.rates {
            let rateString = String(format: "%.2f", rate * 100/100)
            let item = Rate(code: code, rate: rateString)
            rates.append(item)
        }
        
        rates.sort{
            $0 < $1
        }
    }

    init(with base: String, exchageRates: [String : Double]) {
        self.base = base

        for (code, rate) in exchageRates {
            let rateString = String(format: "%.2f", rate * 100/100)
            let item = Rate(code: code, rate: rateString)
            rates.append(item)
        }

        rates.sort{
            $0 < $1
        }
    }
}
