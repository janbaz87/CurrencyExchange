//
//  ExchangeRatesRouterTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 09/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class ExchangeRatesRouterTests: XCTestCase {

    func test_build_exchange_rates_called() {
        let builder = ExchangeRatesBuilderSpy()
        let sut = makeSUT(builder: builder)

        sut.showExchageRatesView(on: UIWindow())

        XCTAssertTrue(builder.buildExchangeRatesCalled)
    }

    func test_present_currency_lists_called() {
        // Given
        let router = CurrenciesListRouterSpy()
        let sut = makeSUT(router: router)
        let selectionHandler: (Currency?) -> Void = { currency in
            // Implement a test selection handler logic if needed
        }

        // When
        sut.presentCurrencyList(with: selectionHandler)

        // Then
        XCTAssertTrue(router.presentCurrenciesListCalled)
    }

    // Helpers
    private func makeSUT(
        builder: ExchangeRatesBuildable = ExchangeRatesBuilderSpy(),
        router: CurrenciesListRouting = CurrenciesListRouterSpy()
    ) -> ExchangeRatesRouting {
        let sut = ExchangeRatesRouter(builder: builder, currenciesListRouter: router)

        return sut
    }
}
