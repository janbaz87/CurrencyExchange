//
//  CurrenciesListDataSourceTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 09/11/2023.
//

import XCTest
@testable import CurrenyExchange

class CurrenciesListDataSourceTests: XCTestCase {

    func test_get_item_at_index() {
        // Given
        let currencies = Mocks.currencies

        // Create an instance of CurrenciesListDataSource
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let dataSource = CurrenciesListDataSource(collectionView: collectionView)

        // When
        dataSource.currencies = currencies

        // Then
        XCTAssertEqual(dataSource.getItem(at: IndexPath(item: 0, section: 0)), currencies[0])
        XCTAssertEqual(dataSource.getItem(at: IndexPath(item: 1, section: 0)), currencies[1])
        XCTAssertEqual(dataSource.getItem(at: IndexPath(item: 2, section: 0)), currencies[2])
        XCTAssertNil(dataSource.getItem(at: IndexPath(item: 3, section: 0)))
    }

    func test_apply_snapshot() {
        // Given
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let dataSource = CurrenciesListDataSource(collectionView: collectionView)

        // When
        dataSource.currencies = Mocks.currencies

        // Then
        let sectionIdentifier = CurrenciesListLayoutKind.currencySection
        let snapshot = dataSource.dataSource.snapshot()
        XCTAssertEqual(snapshot.numberOfItems, 3)
        XCTAssertTrue(snapshot.sectionIdentifiers.contains(sectionIdentifier))
        XCTAssertEqual(snapshot.numberOfItems(inSection: sectionIdentifier), 3)
    }
}
