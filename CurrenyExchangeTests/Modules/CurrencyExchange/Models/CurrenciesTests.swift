//
//  CurrenciesTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 06/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class CurrenciesTests: XCTestCase {

    func test_creation_of_currencies_model_from_currency_list_model() {
        // Given
        let currencyListModel = CurrencyListResponse.mock

        // When
        let sut = Currencies(with: currencyListModel)

        // Then

        XCTAssertEqual(currencyListModel.currencies.keys.sorted().first, sut.currencyList.first?.code)
        XCTAssertEqual(currencyListModel.currencies[currencyListModel.currencies.keys.sorted()[0]], sut.currencyList.first?.name)
    }
}
