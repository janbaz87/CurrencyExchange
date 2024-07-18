//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Janbaz Ali on 02/11/2023.
//

import XCTest
@testable import Networking

final class NetworkingTests: XCTestCase {

    func test_error_case() {
        let httpClient = HTTPClientStub(result: errorResult())
        let sut = maekSUT(httpClient: httpClient)
        let requestable = makeURLResquestable()
        let expectedResult = NetworkError.invalidURL

        Task.detached {
            let result = await sut.request(requestable: requestable, responseType: String.self)

            switch result {
            case .success(_):
                XCTFail("Request failed with error")
            case .failure(let error):
                XCTAssertEqual(error, expectedResult, "Response should match expected model")
            }
        }

    }

    func test_http_client_perform_request_called() {
        let httpClient = HTTPClientStub(result: errorResult())
        let sut = maekSUT(httpClient: httpClient)
        let requestable = makeURLResquestable()

        Task.detached {
            let _ = await sut.request(requestable: requestable, responseType: String.self)
            XCTAssertTrue(httpClient.performRequestCalled)
        }

    }

    private func maekSUT(httpClient: HTTPClient) -> NetworkProviding {
        return Networking(requestFactory: URLRequestFactory(),
                          urlSession: httpClient)
    }

    func makeURLResquestable() -> URLRequestable {
        let urlRequestable = URLRequestableMock()
        return urlRequestable
    }

    private func errorResult() -> Result<(Data, URLResponse), Error> {
        return  Result<(Data, URLResponse), Error>.failure(NetworkError.invalidURL)
    }
}

fileprivate class HTTPClientStub: HTTPClient {

    private let result: Result<(Data, URLResponse), Error>

    fileprivate init(result: Result<(Data, URLResponse), Error>) {
        self.result = result
    }

    func perform(request: URLRequest) async -> Result<(Data, URLResponse), Error> {
        performRequestCalled = true
        return result
    }

    var performRequestCalled = false

}
