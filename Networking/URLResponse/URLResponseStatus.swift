//
//  URLResponseStatus.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//

enum URLResponseStatus : Equatable {
    case success
    case failure(NetworkError)
}

extension URLResponse {
    var responseStatus: URLResponseStatus {
        guard let httpResponse = self as? HTTPURLResponse else {
            return .failure(.noHTTPResponse)
        }

        switch httpResponse.statusCode {
        case 200...299:
            return .success
        case 400...499:
            return .failure(NetworkError.clientError)
        case 500...:
            return .failure(NetworkError.serverError)
        default:
            return .failure(NetworkError.unknown)
        }
    }
}
