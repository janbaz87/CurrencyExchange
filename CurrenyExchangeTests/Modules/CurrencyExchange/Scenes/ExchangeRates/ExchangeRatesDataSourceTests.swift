//
//  ExchangeRatesDataSourceTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 09/11/2023.
//

import XCTest
@testable import CurrenyExchange

class ExchangeRatesDataSourceTests: XCTestCase {

    func testGetItemAtIndex() {
        // Create a test exchange rates list
        let exchangeRates = Mocks.rates

        // Create an instance of ExchangeRatesDataSource
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let dataSource = ExchangeRatesDataSource(collectionView: collectionView)

        // Set the test exchange rates
        dataSource.exchangeRates = exchangeRates

        // Test getting items at specific indexes
        XCTAssertEqual(dataSource.getItem(at: IndexPath(item: 0, section: 0)), exchangeRates[0])
        XCTAssertEqual(dataSource.getItem(at: IndexPath(item: 1, section: 0)), exchangeRates[1])
        XCTAssertEqual(dataSource.getItem(at: IndexPath(item: 2, section: 0)), exchangeRates[2])
        XCTAssertNil(dataSource.getItem(at: IndexPath(item: 3, section: 0)))
    }

    func testApplySnapshot() {
        // Create an instance of ExchangeRatesDataSource
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let dataSource = ExchangeRatesDataSource(collectionView: collectionView)

        // Create a test exchange rates list
        let exchangeRates = Mocks.rates

        // Apply the snapshot
        dataSource.exchangeRates = exchangeRates

        // Test if the snapshot is applied correctly
        let sectionIdentifier = ExchangeRatesLayoutKind.ratesSection
        let snapshot = dataSource.dataSource.snapshot()
        XCTAssertEqual(snapshot.numberOfItems, 3)
        XCTAssertTrue(snapshot.sectionIdentifiers.contains(sectionIdentifier))
        XCTAssertEqual(snapshot.numberOfItems(inSection: sectionIdentifier), 3)
    }
}

