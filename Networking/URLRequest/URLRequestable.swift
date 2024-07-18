//
//  URLRequestable.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//

public protocol URLRequestable: BaseURLHaving {
    var method: HTTPMethod { get }

    var path: String { get }

    var parameters: Encodable? { get }

    var headers: [String: String]? { get }
}

extension URLRequestable {
    public var parameters: Encodable? {
        nil
    }

    public var headers: [String: String]? {
        nil
    }
}
