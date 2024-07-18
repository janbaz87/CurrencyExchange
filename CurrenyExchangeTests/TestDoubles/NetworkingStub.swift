//
//  NetworkingStub.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 06/11/2023.
//

import XCTest
import Networking
@testable import CurrenyExchange

final class NetworkingStub: NetworkProviding {
    func request<T>(requestable: URLRequestable, responseType: T.Type) async -> Result<T, NetworkError> where T : Decodable {
        requestCalled = true
        return .failure(.unknown)
    }

    var requestCalled = false
}
