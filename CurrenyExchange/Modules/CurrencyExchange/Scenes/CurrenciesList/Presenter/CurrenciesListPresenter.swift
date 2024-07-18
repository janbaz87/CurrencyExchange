//
//  CurrenciesListPresenter.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import Foundation

protocol CurrenciesListPresentation {
    func viewDidLoad()
    func didSelect(currency selectedCurrency: Currency?)
}

final class CurrenciesListPresenter: CurrenciesListPresentation {
    // MARK: - Init
    init (
        interactor: CurrenciesListInteractorInputing,
        router: CurrenciesListRouting,
        selectionHandler: @escaping (Currency?) -> Void
    ) {
        self.interactor = interactor
        self.router = router
        self.selectionHandler = selectionHandler
    }

    // MARK: - Internal
    weak var view: CurrenciesListView?

    func viewDidLoad() {
        interactor.fetchCurrenciesList()
    }

    func didSelect(currency selectedCurrency: Currency?) {
        selectionHandler?(selectedCurrency)
        router.dismiss()
    }

    // MARK: - Private
    private let interactor: CurrenciesListInteractorInputing
    private let router: CurrenciesListRouting
    private var selectionHandler: ((Currency?) -> Void)?
}

// MARK: - CurrenciesListInteractorOutputing
extension CurrenciesListPresenter: CurrenciesListInteractorOutputing {

    @MainActor
    func successfullyFetchedCurrencies(currencies: Currencies?) {
        guard let currencies = currencies else { return }

        view?.setCurrenciesListData(currencies: currencies.currencyList)
    }

}
