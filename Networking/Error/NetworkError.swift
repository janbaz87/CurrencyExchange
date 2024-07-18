//
//  NetworkError.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//

public enum NetworkError: Error {
    case noHTTPResponse
    case clientError
    case serverError
    case invalidURL
    case serialization
    case unknown
}
