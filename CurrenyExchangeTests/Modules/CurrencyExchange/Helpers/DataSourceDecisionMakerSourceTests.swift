//
//  DataSourceDecisionMakerSource.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class DataSourceDecisionMakerSourceTests: XCTestCase {

    func test_when_the_time_difference_is_greater_than_thirty() {
        // Given
        let sut = DataSourceDecisionMaker()
        let lastFetchedDate = makeDateWith(minutes: -30)
        let expected = DataSource.remote

        // When

        let result = sut.getDataSource(with: lastFetchedDate)

        // Then
        XCTAssertEqual(expected, result)
    }

    func test_when_the_time_difference_is_less_than_thirty() {
        // Given
        let sut = DataSourceDecisionMaker()
        let lastFetchedDate = makeDateWith(minutes: -29)
        let expected = DataSource.local

        // When

        let result = sut.getDataSource(with: lastFetchedDate)

        // Then
        XCTAssertEqual(expected, result)
    }

    // MARK: - Helpers

    private func makeDateWith(minutes: Int) -> Date {
        let currentDate = Date()

        let calendar = Calendar.current

        let minutesToSubtract = minutes

        var dateComponents = DateComponents()
        dateComponents.minute = minutesToSubtract

        if let newDate = calendar.date(byAdding: dateComponents, to: currentDate) {
            return newDate
        } else {
            print("Error occurred when calculating the new date.")
            return currentDate
        }
    }

}
