//
//  ExchangeRatesTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 06/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class ExchangeRatesTests: XCTestCase {

    func test_creation_of_exchange_rate_model_from_currency_exchange_rate_response() {
        // Given
        let base = "USA"
        let currency = "PKR"
        let rate = 285.98776
        let expectedRate = "285.99" // because conversion from double to string rouds off the digits
        let exchangeRates = CurrencyExchangeRateResponse(base: base, rates: [currency: rate])

        // When
        let sut = ExchangeRates(with: exchangeRates)

        // Then

        XCTAssertEqual(exchangeRates.base, sut.base)
        XCTAssertEqual(currency, sut.rates.first?.code)
        XCTAssertEqual(expectedRate, sut.rates.first?.rate)
    }

}
