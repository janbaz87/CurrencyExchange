//
//  DataFetchingDecisionMaker.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 06/11/2023.
//

import Foundation

enum DataSource {
    case local
    case remote
}

protocol DataSourceDecisionMaking {
    func getDataSource(with timestamp: Date?) -> DataSource
}

final class DataSourceDecisionMaker: DataSourceDecisionMaking {

    // MARK: - Internal
    func getDataSource(with lastFetchTimestamp: Date?) -> DataSource {
        guard let lastFetchTimestamp = lastFetchTimestamp else {
            return .remote
        }

        let difference = Date().timeIntervalSince(lastFetchTimestamp)

        if  difference > Constants.timeInMinutes * Constants.secondsInOneMinutes {
            return .remote
        } else {
            return .local
        }
    }

    // MARK: - Private
    private enum Constants {
        static let timeInMinutes = 30.0
        static let secondsInOneMinutes = 60.0
    }
}
