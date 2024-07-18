//
//  URLRequestFactoryTests.swift
//  NetworkingTests
//
//  Created by Janbaz Ali on 03/11/2023.
//

import XCTest
@testable import Networking

final class URLRequestFactoryTests: XCTestCase {

    func test_creating_url_request_from_url_requestable_for_get_http_method() {
        // Given
        let sut = makeSut()
        let urlRequestable = makeURLResquestable()

        let expectedUrlString = urlRequestable.baseURL + urlRequestable.path + "?" + "app_id=123456"

        do {
            // When
            let request = try sut.makeURLRequest(with: urlRequestable)

            // Then
            XCTAssertEqual(expectedUrlString, request.url?.absoluteString)
            XCTAssertEqual(HTTPMethod.get.rawValue, request.httpMethod)
        } catch {
            XCTFail("Request failed with error: \(error)")
        }
    }


    // MARK: - Private Helpers

    func makeSut() -> URLRequestMaking {
        let urlRequestFactory = URLRequestFactory()
        return urlRequestFactory
    }

    func makeURLResquestable() -> URLRequestable {
        let urlRequestable = URLRequestableMock()
        return urlRequestable
    }
}
