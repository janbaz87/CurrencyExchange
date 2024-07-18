//
//  URLRequestEncodingDecisionMaker.swift
//  Networking
//
//  Created by Janbaz Ali on 02/11/2023.
//

enum URLRequestEncodingDecisionMaker {
    static func encodingType(for method: HTTPMethod) -> URLRequestEncoding {
        switch method {
        case .get, .delete:
            return .urlEncoding
        case .post, .put, .patch:
            return .jsonEncoding
        }
    }
}

