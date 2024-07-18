//
//  ExchangeRatesBuilder.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import Foundation
import Networking
import UIKit

protocol ExchangeRatesBuildable {
    func buildExchangeRates(router: ExchangeRatesRouting) -> ExchangeRatesViewController
}

final class ExchangeRatesBuilder: ExchangeRatesBuildable {

    // MARK: - Internal
    func buildExchangeRates(router: ExchangeRatesRouting) -> ExchangeRatesViewController {
        let networking = Networking()
        let service = CurrencyService(networking: networking)
        let repository = CurrencyExchangeRepository(
            service: service,
            localStore: UserDefaultsDataStore(with: UserDefaultsWrapper()),
            dataSourceDecisionMaker: DataSourceDecisionMaker(),
            currencyConverter: CurrencyConverter()
        )

        let interactor = ExchangeRatesInteractor(repository: repository)
        let presenter = ExchangeRatesPresenter(
            interactor: interactor,
            router: router
        )
        interactor.output = presenter
        let view = ExchangeRatesViewController(presenter: presenter)
        presenter.view = view

        return view
    }

}
