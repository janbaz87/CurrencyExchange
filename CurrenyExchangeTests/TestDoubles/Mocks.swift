//
//  Mocks.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

import Foundation
@testable import CurrenyExchange

class Mocks {
    static var currenciesObject : Currencies {
        let currenciesList = [currency]
        return  Currencies(currencyList: currenciesList)
    }

    static var exchangeRates : ExchangeRates {
        let rates = [rate]
        return ExchangeRates(base: "USD", rates: rates)
    }

    static var currency: Currency {
        Currency(code: "USD", name: "United States Dollar")
    }

    static var rate: Rate {
        Rate(code: "USD", rate: "1.0")
    }

    static var rates: [Rate] {
        [Rate(code: "USD", rate: "1.0"),
         Rate(code: "PKR", rate: "2.0"),
         Rate(code: "IND", rate: "3.0")]
    }

    static var baseCurrency: String {
        "USD"
    }

    static var baseAmount: Double {
        1.0
    }

    static var currencies: [Currency] {
        [Currency(code: "USD", name: "United States Dollar"),
         Currency(code: "PKR", name: "Pakistani Rupee"),
         Currency(code: "INR", name: "Indian Rupee")]
    }
}
