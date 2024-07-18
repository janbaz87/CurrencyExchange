//
//  CurrenciesListPresenterTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class CurrenciesListPresenterTests: XCTestCase {

    func test_view_did_load() {
        // Given
        let interactor = CurrenciesListInteractorSpy()
        let sut = makeSUT(interactor: interactor)
        let view = CurrenciesListViewSpy()
        sut.view = view
        interactor.output = sut

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(interactor.fetchCurrenciesCalled)
        XCTAssertTrue(view.setCurrenciesCalled)
    }

    func test_dismiss() {
        // Given
        let router = CurrenciesListRouterSpy()
        let sut = makeSUT(router: router)

        // When
        sut.didSelect(currency: Mocks.currency)

        // Then
        XCTAssertTrue(router.dimissCalled)
    }

    // Helpers
    private func makeSUT(
        interactor: CurrenciesListInteractorInputing = CurrenciesListInteractorSpy(),
        router: CurrenciesListRouting = CurrenciesListRouterSpy()
    ) -> CurrenciesListPresenter {
        let selectionHandler: (Currency?) -> Void = { currency in
            // Implement a test selection handler logic if needed
        }

        let sut = CurrenciesListPresenter(
            interactor: interactor,
            router: router,
            selectionHandler: selectionHandler
        )

        return sut
    }
}
