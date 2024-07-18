//
//  URLRequestMaking.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//

public protocol URLRequestMaking {
    func makeURLRequest<T: URLRequestable>(with requestable: T) throws -> URLRequest
}
