//
//  HTTPClient.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//

protocol HTTPClient {
    func perform(request: URLRequest) async -> Result<(Data, URLResponse), Error>
}

extension URLSession: HTTPClient {
    func perform(request: URLRequest) async -> Result<(Data, URLResponse), Error> {
        struct InvalidHTTPRequesError: Error {}

        do {
            let result = try await data(for: request)
            return .success(result)
        } catch let error {
            return .failure(error)
        }
    }
}
