//
//  Networking.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//

import Foundation

final public class Networking: NetworkProviding {

    // MARK: -  Public
    public convenience init () {
        self.init(requestFactory: URLRequestFactory())
    }

    public func request<T: Decodable>(
        requestable: URLRequestable,
        responseType: T.Type
    ) async -> Result<T, NetworkError> {
        do {
            let urlRequest = try requestFactory.makeURLRequest(with: requestable)
            let result = await httpClient.perform(request: urlRequest)
            switch result {
            case .success(let (data, response)):
                data.prettyJson()
                return didSucceedExecutingRequest(data: data, response: response, responseType: responseType)
            case .failure(_):
                let error = NetworkError.invalidURL
                return .failure(error)
            }
        }
        catch {
            let error = NetworkError.unknown
            return .failure(error)
        }
    }

    // MARK: - Private

    private let requestFactory: URLRequestMaking
    private let  httpClient: HTTPClient

    init(
        requestFactory: URLRequestMaking,
        urlSession: HTTPClient = URLSession(configuration: .default)
    ) {
        self.requestFactory = requestFactory
        self.httpClient = urlSession
    }

    private func didSucceedExecutingRequest<T: Decodable>(
        data: Data,
        response: URLResponse,
        responseType _: T.Type
    ) -> Result<T, NetworkError> {
        let httpResponseStatus = response.responseStatus
        switch httpResponseStatus {
        case .success:
            do {
                let successModel: T = try JSONParser.decode(value: data)
                return .success(successModel)
            }
            catch {
                return .failure(NetworkError.serialization)
            }
        case .failure(let responseError):
            return .failure(responseError)
        }
    }
}

extension Data {
    func prettyJson() {
            do {
                // Attempt to serialize the data to JSON with proper indentation
                let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)

                // Convert the JSON data to a pretty-printed string
                if let prettyPrintedString = String(data: jsonData, encoding: .utf8) {
                    print(prettyPrintedString)
                }
            } catch {
                print("Error converting data to pretty JSON: \(error)")
            }
        }
}
