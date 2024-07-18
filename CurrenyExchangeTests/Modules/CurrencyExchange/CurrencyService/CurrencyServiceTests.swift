//
//  CurrencyServiceTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 06/11/2023.
//

import XCTest
import Networking
@testable import CurrenyExchange

final class CurrencyServiceTests: XCTestCase {

    func test_networking_request_called_when_currency_list_fetched() async {
        let networking = NetworkingStub()
        let sut = makeSUT(networking: networking)

        let _ = await sut.fetchCurrenciesList()

        XCTAssertTrue(networking.requestCalled)
    }

    func test_networking_request_called_when_exchange_rates_fetched() async {
        let networking = NetworkingStub()
        let sut = makeSUT(networking: networking)

        let _ = await sut.fetchCurrencyExchangeRates()

        XCTAssertTrue(networking.requestCalled)
    }

    // MARK: - Private Helpers

    private func makeSUT(networking: NetworkProviding = NetworkingStub()) -> CurrencyService {
        CurrencyService(networking: networking)
    }

}
