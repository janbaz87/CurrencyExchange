//
//  CodableMock.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 05/11/2023.
//

import Foundation

struct CodableMock: Codable, Equatable {
    var xyz: String = "testing mock"

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.xyz == rhs.xyz
    }

}
