//
//  Currencies.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 05/11/2023.
//

import Foundation

struct Currency: Comparable, Hashable {
    let code: String
    let name: String

    // MARK: - Init
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }

    // MARK: - Comparable
    static func < (lhs: Currency, rhs: Currency) -> Bool {
        lhs.code < rhs.code
    }

    // MARK: - Hashable
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        lhs.code == rhs.code &&
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
        hasher.combine(name)
    }
}

struct Currencies {
    var currencyList: [Currency] = []

    // MARK: - Init
    init(currencyList: [Currency]) {
        self.currencyList = currencyList
    }
}

extension Currencies {

    // MARK: - Init with CurrencyListResponse

    init(with currenciesObject: CurrencyListResponse) {
        for (code, name) in currenciesObject.currencies {
            let item = Currency(code: code, name: name)
            currencyList.append(item)
        }
        currencyList.sort{
            $0 < $1
        }
    }

}
