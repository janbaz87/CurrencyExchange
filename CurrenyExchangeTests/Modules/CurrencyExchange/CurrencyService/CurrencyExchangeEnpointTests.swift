//
//  CurrencyExchangeEnpointTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 06/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class CurrencyExchangeEnpointTests: XCTestCase {

    func test_end_point_path_for_currencies_list() {
        // Given
        let path = "currencies.json"

        // When
        let pathFromEndpoint = CurrencyExchangeEndpoint.currenciesList.path

        // Then
        XCTAssertEqual(path, pathFromEndpoint)
    }

    func test_end_point_path_for_exchage_rates() {
        // Given
        let path = "latest.json"

        // When
        let pathFromEndpoint = CurrencyExchangeEndpoint.exchageRates.path

        // Then
        XCTAssertEqual(path, pathFromEndpoint)
    }

}
