//
//  BaseRequestable.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 02/11/2023.
//

import Networking

protocol BaseRequest: URLRequestable { }

extension BaseRequest {
    var baseURL: String {
        AppConfiguration.baseURL
    }
}
