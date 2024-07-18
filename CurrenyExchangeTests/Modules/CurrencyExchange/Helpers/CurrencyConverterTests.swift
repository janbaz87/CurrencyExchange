//
//  CurrencyConverterTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class CurrencyConverterTests: XCTestCase {

    func test_currency_conversion_when_amount_is_one() {
        // Given
        let sut = CurrencyConverter()
        let currencyListModel = ["PKR" : 4.0,
                                 "INR" : 2.0,
                                 "AED" : 6.0,
                                 "JPY" : 8.0,
                                 "USD": 1.0]
        let selected = "PKR"
        let base = "USD"
        let amount = 1.0
        let expected = ["PKR" : 1.0,
                        "INR" : 0.5,
                        "AED" : 1.5,
                        "JPY" : 2.0,
                        "USD": 0.25]

        // When
        let converted = sut.convertAmount(amount: amount, with: base, to: selected, from: currencyListModel)

        // Then
        XCTAssertEqual(converted, expected)
    }

    func test_currency_conversion_when_amount_is_more_than_one() {
        // Given
        let sut = CurrencyConverter()
        let currencyListModel = ["PKR" : 4.0,
                                 "INR" : 2.0,
                                 "AED" : 6.0,
                                 "JPY" : 8.0,
                                 "USD": 1.0]
        let selected = "PKR"
        let base = "USD"
        let amount = 2.0
        let expected = ["PKR" : 2.0,
                        "INR" : 1.0,
                        "AED" : 3.0,
                        "JPY" : 4.0,
                        "USD": 0.5]

        // When
        let converted = sut.convertAmount(amount: amount, with: base, to: selected, from: currencyListModel)

        // Then
        XCTAssertEqual(converted, expected)
    }

    func test_when_selected_currency_does_not_exist() {
        // Given
        let sut = CurrencyConverter()
        let currencyListModel = ["PKR" : 4.0,
                                 "INR" : 2.0,
                                 "AED" : 6.0,
                                 "JPY" : 8.0,
                                 "USD": 1.0]
        let selected = "XYZ"
        let base = "USD"
        let amount = 1.0

        // When
        let converted = sut.convertAmount(amount: amount, with: base, to: selected, from: currencyListModel)

        // Then
        XCTAssertEqual(converted, currencyListModel)
    }
}
