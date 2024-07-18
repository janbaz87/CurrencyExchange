//
//  URLRequestDecisionMakerTests.swift
//  NetworkingTests
//
//  Created by Janbaz Ali on 03/11/2023.
//

import XCTest
@testable import Networking

final class URLRequestEncodingDecisionMakerTests: XCTestCase {

    // MARK: - Private Helpers

    func test_request_encoding_decision() {
        let sut = URLRequestEncodingDecisionMaker.self
        var extpected = URLRequestEncoding.urlEncoding

        var encoding = sut.encodingType(for: HTTPMethod.get)
        XCTAssertEqual(extpected, encoding)
        encoding = sut.encodingType(for: HTTPMethod.delete)
        XCTAssertEqual(extpected, encoding)

        extpected = URLRequestEncoding.jsonEncoding

        encoding = sut.encodingType(for: HTTPMethod.put)
        XCTAssertEqual(extpected, encoding)
        encoding = sut.encodingType(for: HTTPMethod.post)
        XCTAssertEqual(extpected, encoding)
        encoding = sut.encodingType(for: HTTPMethod.patch)
        XCTAssertEqual(extpected, encoding)
    }

}
