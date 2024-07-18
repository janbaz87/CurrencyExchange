//
//  CurrencyListBuilderTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

import XCTest
@testable import CurrenyExchange

class CurrencyListBuilderTests: XCTestCase {

    func test_build_currencies_list() {
        // Given
        // Create a selection handler for testing
        let selectionHandler: (Currency?) -> Void = { currency in
            // Implement a test selection handler logic if needed
        }

        // When
        // Build the currencies list view controller
        let router = CurrenciesListRouter()
        let sut = CurrenciesListBuilder()
        let currenciesListVC = sut.buildCurrenciesList(with: router, selectionHandler: selectionHandler)

        // Then
        // Verify that the currenciesListVC and its dependencies are set up correctly
        XCTAssertNotNil(currenciesListVC.presenter)
        XCTAssertTrue(currenciesListVC.presenter is CurrenciesListPresenter)
    }
}

