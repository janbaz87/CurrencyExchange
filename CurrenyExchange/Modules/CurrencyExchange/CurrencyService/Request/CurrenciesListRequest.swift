//
//  CurrenciesListRequest.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 02/11/2023.
//
import Networking

struct CurrenciesListRequest: BaseRequest {
    var method: HTTPMethod = .get
    var path: String
    var parameters: Encodable?
}
