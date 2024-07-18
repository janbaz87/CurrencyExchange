//
//  UserDefaultsWrapperTests.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 04/11/2023.
//

import XCTest
@testable import CurrenyExchange

final class UserDefaultsWrapperTests: XCTestCase {

    func test_encoding_and_decoding() {
        // Given
        let sut = UserDefaultsWrapper()
        let codableObject = CodableMock()
        let key = "userdefaults_key_for_testing"

        // When
        sut.save(codableObject, forKey: key)
        let result: CodableMock? = sut.load(forKey: key)

        // Then
        XCTAssertEqual(result, codableObject)
    }

}

