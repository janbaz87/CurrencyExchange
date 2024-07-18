//
//  DataStorageTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 05/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class DataStoreTests: XCTestCase {

    func test_nil_in_currencies_list_before_saving() {
        // Given
        let sut = makeSUT()

        // When
        let result: Codable? = sut.getCurrenciesList()

        // Then

        XCTAssertNil(result)
    }

    func test_nil_in_exchange_rates_before_saving() {
        // Given
        let sut = makeSUT()

        // When
        let result: Codable? = sut.getExchangeRates()

        // Then

        XCTAssertNil(result)
    }

    func test_storing_and_fetching_currencies_list() {
        // Given
        let sut = makeSUT()

        // When
        sut.storeCurreniesList(currencies: CurrencyListResponse.mock)
        let result: CurrencyListResponse? = sut.getCurrenciesList()

        // Then

        XCTAssertEqual(CurrencyListResponse.mock, result)
    }

    func test_storing_and_fetching_exchange_rates_list() {
        // Given
        let sut = makeSUT()
        let object = CurrencyExchangeRateResponse(base: "USD", rates: ["AED" : 23])

        // When
        sut.storeExchageRates(rates: object)
        let result: CurrencyExchangeRateResponse? = sut.getExchangeRates()

        // Then

        XCTAssertEqual(object, result)
    }


   // MARK: - Private
    fileprivate func makeSUT() -> UserDefaultsDataStore {
        UserDefaultsDataStore(with: UserDefaultsWrapperStub(with: CodableMock()))
    }

}

fileprivate class UserDefaultsWrapperStub: UserDefaultsWrapping {
    func saveDate(date: Date, forKey key: String) {

    }

    func loadDate(forKey key: String) -> Date? {
        Date()
    }

    var object: Codable?

    func save<T>(_ object: T, forKey key: String) where T : Decodable, T : Encodable {
        self.object = object
    }

    func load<T>(forKey key: String) -> T? where T : Decodable, T : Encodable {
        object as? T
    }

    init(with object: Codable) {
        self.object = object
    }

}
