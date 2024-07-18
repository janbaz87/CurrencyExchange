//
//  URLRequestableMock.swift
//  NetworkingTests
//
//  Created by Janbaz Ali on 03/11/2023.
//

@testable import Networking

struct URLRequestableMock: URLRequestable {
    var method: HTTPMethod = .get

    var path: String = "latest.json"

    var baseURL: String = "https://openexchangerates.org/"

    var parameters: Encodable? = URLRequestParameterMock()
}

struct URLRequestParameterMock: Encodable {
    let app_id = "123456"
}
