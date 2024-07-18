//
//  URLRequestFactory.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//

public struct URLRequestFactory: URLRequestMaking {

    private let jsonEncoder = JSONEncoder()

    // MARK: - Internal functions
    public func makeURLRequest<T: URLRequestable>(with requestable: T) throws -> URLRequest {
        guard var url = URL(string: requestable.baseURL) else {
            throw NetworkError.invalidURL
        }

        url.appendPathComponent(requestable.path)

        var encodedParameters: Data?
        if let parameters = requestable.parameters {
            guard let encoded = try? jsonEncoder.encode(parameters) else {
                throw NetworkError.serialization
            }
            encodedParameters = encoded
        }

        let encodingType = URLRequestEncodingDecisionMaker.encodingType(for: requestable.method)

        switch encodingType {
        case .urlEncoding:
            return try urlRequestForURLEncoding(
                url: url,
                parameters: encodedParameters,
                headers: requestable.headers,
                httpMethod: requestable.method
            )
        case .jsonEncoding:
            return urlRequestForJSONEncoding(
                url: url,
                parameters: encodedParameters,
                headers: requestable.headers,
                httpMethod: requestable.method
            )
        }
    }

}

// MARK: - Helpers
extension URLRequestFactory {
    private func urlRequestForURLEncoding(
        url: URL,
        parameters: Data?,
        headers: [String: String]?,
        httpMethod: HTTPMethod
    ) throws -> URLRequest {
        if let parameters = parameters,
           let queryParameters = try? JSONSerialization.jsonObject(
               with: parameters,
               options: .fragmentsAllowed
           ) as? [String: Any],
           !queryParameters.isEmpty {
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                throw NetworkError.invalidURL
            }

            components.queryItems = queryParameters.map {
                if type(of: $0.value) == type(of: NSNumber(value: true)),
                   let value = $0.value as? Bool {
                    return URLQueryItem(name: $0.key, value: "\(value)")
                }
                return URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
            guard let finalURL = components.url else {
                throw NetworkError.invalidURL
            }
            var urlRequest = URLRequest(url: finalURL)
            urlRequest.httpMethod = httpMethod.rawValue
            addHeaders(headers, for: &urlRequest)
            return urlRequest
        } else {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod.rawValue
            addHeaders(headers, for: &urlRequest)
            return urlRequest
        }
    }

    private func urlRequestForJSONEncoding(
        url: URL,
        parameters: Data?,
        headers: [String: String]?,
        httpMethod: HTTPMethod
    ) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = parameters
        urlRequest.httpMethod = httpMethod.rawValue
        addHeaders(headers, for: &urlRequest)
        return urlRequest
    }

    private func addHeaders(_ headers: [String: String]?, for request: inout URLRequest) {
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
}
