//
//  HTTPMethod.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//

public enum HTTPMethod: String, Codable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
