//
//  CurrenciesListViewSpy.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

@testable import CurrenyExchange

class CurrenciesListViewSpy: CurrenciesListView {
    
    var setCurrenciesCalled = false

    func setCurrenciesListData(currencies: [CurrenyExchange.Currency]) {
        setCurrenciesCalled = true
    }
}
