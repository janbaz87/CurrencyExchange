//
//  ExchangeRatesPresenterTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 09/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class ExchangeRatesPresenterTests: XCTestCase {

    func test_fetch_exchnage_rates_called_on_view_did_load() {
        // Given
        let interactor = ExchangeRatesInteractorStub()
        let sut = makeSUT(interactor: interactor)
        interactor.output = sut

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(interactor.fetchExchangeRatesCalled)
    }

    func test_set_exchnage_rates_called_on_view_did_load() {
        // Given
        let interactor = ExchangeRatesInteractorStub()
        let sut = makeSUT(interactor: interactor)
        let view = ExchangeRatesViewSpy()
        sut.view = view
        interactor.output = sut

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(view.setExchangeRatesCalled)
    }

    func test_fetch_exchnage_rates_called_on_done_tapped() {
        let interactor = ExchangeRatesInteractorStub()
        let sut = makeSUT(interactor: interactor)
        let view = ExchangeRatesViewSpy()
        sut.view = view
        interactor.output = sut

        // When
        sut.doneTappedWith(currency: Mocks.baseCurrency, amount: "1.0")

        // Then
        XCTAssertTrue(interactor.fetchExchangeRatesCalled)
        XCTAssertTrue(view.setExchangeRatesCalled)
    }

    func test_present_currencies_list_called_when_select_currency_tapped() {
        // Given
        let router = ExchangeRatesRouterSpy()
        let sut = makeSUT(router: router)

        // When
        sut.selectCurrencyTapped()
        //sut.doneTappedWith(currency: Mocks.baseCurrency, amount: "1.0")

        // Then
        XCTAssertTrue(router.presentCurrencyListCalled)
    }

    // Helpers
    private func makeSUT(
        interactor: ExchangeRatesInteractorInputing = ExchangeRatesInteractorStub(),
        router: ExchangeRatesRouting = ExchangeRatesRouterSpy()
    ) -> ExchangeRatesPresenter {
        let sut = ExchangeRatesPresenter(
            interactor: interactor,
            router: router
        )

        return sut
    }
}
