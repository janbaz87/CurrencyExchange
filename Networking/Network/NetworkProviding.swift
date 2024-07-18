//
//  NetworkProviding.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//

public protocol NetworkProviding {
    func request<T: Decodable>(requestable: URLRequestable, responseType: T.Type) async -> Result<T, NetworkError>
}
