//
//  CurrenciesListRouterTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class CurrenciesListRouterTests: XCTestCase {

    func test_buil_currencies_list_called() {
        let builder = CurrenciesListBuilderSpy()
        let sut = makeSUT(builder: builder)
        let selectionHandler: (Currency?) -> Void = { currency in
            // Implement a test selection handler logic if needed
        }

        sut.presentCurrenciesList(from: UIViewController(), selectionHandler: selectionHandler)

        XCTAssertTrue(builder.buildCurrenciesListCalled)
    }

    // Helpers
    private func makeSUT(builder: CurrenciesListBuilding) -> CurrenciesListRouter {
        let sut = CurrenciesListRouter(builder: builder)

        return sut
    }
}
