//
//  CurrenciesListBuilder.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import Foundation
import Networking
import UIKit

protocol CurrenciesListBuilding {
    func buildCurrenciesList(
        with router: CurrenciesListRouting,
        selectionHandler: @escaping (Currency?) -> Void
    ) -> CurrenciesListViewController
}

final class CurrenciesListBuilder: CurrenciesListBuilding {

    // MARK: - Internal
    func buildCurrenciesList(
        with router: CurrenciesListRouting,
        selectionHandler: @escaping (Currency?) -> Void
    ) -> CurrenciesListViewController {
        let networking = Networking()
        let service = CurrencyService(networking: networking)
        let repository = CurrencyExchangeRepository(
            service: service,
            localStore: UserDefaultsDataStore(with: UserDefaultsWrapper()),
            dataSourceDecisionMaker: DataSourceDecisionMaker(),
            currencyConverter: CurrencyConverter()
        )

        let interactor = CurrenciesListInteractor(repository: repository)
        let presenter = CurrenciesListPresenter(
            interactor: interactor,
            router: router,
            selectionHandler: selectionHandler
        )
        let view = CurrenciesListViewController(presenter: presenter)
        presenter.view = view
        interactor.output = presenter
        return view
    }

}
