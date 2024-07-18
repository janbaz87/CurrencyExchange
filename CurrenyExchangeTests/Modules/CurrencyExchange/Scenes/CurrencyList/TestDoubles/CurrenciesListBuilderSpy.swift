//
//  CurrenciesListBuilderSpy.swift
//  CurrenyExchangeTests
//
//  Created by Janbaz Ali on 08/11/2023.
//

@testable import CurrenyExchange

class CurrenciesListBuilderSpy: CurrenciesListBuilding {

    func buildCurrenciesList(
        with router: CurrenciesListRouting,
        selectionHandler: @escaping (Currency?) -> Void
    ) -> CurrenciesListViewController {
        buildCurrenciesListCalled = true
        return CurrenciesListViewController(presenter: CurrenciesListPresenterSpy())
    }
    
    var buildCurrenciesListCalled = false

}
