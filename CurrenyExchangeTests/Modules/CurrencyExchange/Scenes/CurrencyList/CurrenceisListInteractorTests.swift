//
//  CurrenceisListInteractorTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class CurrenceisListInteractorTests: XCTestCase {

    @MainActor
    func test_fetch_currencies_list_calls_right_repository_method() {
        // Given
        let repository = CurrencyExchangeRepositoryStub()
        let sut = makeSUT(repository: repository)

        Task {
            // When
            sut.fetchCurrenciesList()
            // Then
            XCTAssertTrue(repository.fetchCurrenciesCalled)
        }
    }

    @MainActor
    func test_output_passes_the_data_to_correct_method() {
        // Given
        let sut = makeSUT()
        let output = CurrenciesListPresenterSpy()
        sut.output = output

        Task {
            // When
            sut.fetchCurrenciesList()
            // Then
            XCTAssertTrue(output.fetchCurrenciesCalled)
        }
    }

    // Helpers
    private func makeSUT(
        repository: CurrencyExchangeRepositoryProviding = CurrencyExchangeRepositoryStub()
    ) -> CurrenciesListInteractor {
        let sut = CurrenciesListInteractor(repository: repository)

        return sut
    }
}
