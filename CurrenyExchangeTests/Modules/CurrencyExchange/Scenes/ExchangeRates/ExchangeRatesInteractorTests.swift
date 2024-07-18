//
//  ExchangeRatesInteractorTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 09/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class ExchangeRatesInteractorTests: XCTestCase {

    @MainActor
    func test_fetch_currencies_list_calls_right_repository_method() {
        // Given
        let repository = CurrencyExchangeRepositoryStub()
        let sut = makeSUT(repository: repository)

        Task {
            // When
            sut.fetchExchangeRates(for: Mocks.baseCurrency, amount: Mocks.baseAmount)
            // Then
            XCTAssertTrue(repository.fetchExchangeRatesCalled)
        }
    }

    @MainActor
    func test_output_passes_the_data_to_correct_method() {
        // Given
        let sut = makeSUT()
        let output = ExchangeRatesPresenterSpy()
        sut.output = output

        Task {
            // When
            sut.fetchExchangeRates(for: Mocks.baseCurrency, amount: Mocks.baseAmount)
            // Then
            XCTAssertTrue(output.fetchExchangeRatesCalled)
        }
    }

    // Helpers
    private func makeSUT(
        repository: CurrencyExchangeRepositoryProviding = CurrencyExchangeRepositoryStub()
    ) -> ExchangeRatesInteractor {
        let sut = ExchangeRatesInteractor(repository: repository)

        return sut
    }
}
