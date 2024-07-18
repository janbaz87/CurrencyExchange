//
//  URLResponseStatusTests.swift
//  NetworkingTests
//
//  Created by Janbaz Ali on 03/11/2023.
//

import XCTest
@testable import Networking

final class URLResponseStatusTests: XCTestCase {

    func test_urlResponse_status_success_case() {
        let sut = makeSUT(code: 200)

        let status = sut?.responseStatus
        let expected = URLResponseStatus.success

        XCTAssertEqual(expected, status)
    }

    func test_urlResponse_status_failure_unknown_case() {
        let sut = makeSUT(code: 300)

        let status = sut?.responseStatus
        let expected = URLResponseStatus.failure(NetworkError.unknown)

        XCTAssertEqual(expected, status)
    }

    func test_urlResponse_status_failure_clientError_case() {
        let sut = makeSUT(code: 400)

        let status = sut?.responseStatus
        let expected = URLResponseStatus.failure(NetworkError.clientError)

        XCTAssertEqual(expected, status)
    }

    func test_urlResponse_status_failure_serverError_case() {
        let sut = makeSUT(code: 500)

        let status = sut?.responseStatus
        let expected = URLResponseStatus.failure(NetworkError.serverError)

        XCTAssertEqual(expected, status)
    }

    private func makeSUT(code: Int) -> URLResponse? {
        HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: code, httpVersion: "HTTP/1.1", headerFields: nil)
    }

}
