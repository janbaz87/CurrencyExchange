//
//  ExchangeRatesPresenter.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import Foundation

protocol ExchangeRatesPresentation {
    func viewDidLoad()
    func selectCurrencyTapped()
    func doneTappedWith(currency: String?, amount: String?)
}

final class ExchangeRatesPresenter: ExchangeRatesPresentation {
    // MARK: - Init
    init (
        interactor: ExchangeRatesInteractorInputing,
        router: ExchangeRatesRouting
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Internal
    weak var view: ExchangeRatesView?

    func viewDidLoad() {
        interactor.fetchExchangeRates(for: Constants.defaultCurrency, amount: Constants.defaultAmount)
    }

    func selectCurrencyTapped() {
        router.presentCurrencyList { [weak self] currency in
            guard let self = self, let code = currency?.code else { return }
            view?.newCurrencySelected(currency: code)
        }
    }

    func doneTappedWith(currency: String?, amount: String?) {
        let amountDouble = (amount ?? String.empty).isEmpty ? Constants.defaultAmount : Double(amount ?? Constants.defaultAmountString)
        interactor.fetchExchangeRates(for: currency, amount: amountDouble)
    }

    // MARK: - Private
    private let interactor: ExchangeRatesInteractorInputing
    private let router: ExchangeRatesRouting

    private enum Constants {
        static let defaultCurrency = "USD"
        static let defaultAmount = 1.0
        static let defaultAmountString = "1.0"
    }
}

// MARK: - ExchangeRatesInteractorOutputing
extension ExchangeRatesPresenter: ExchangeRatesInteractorOutputing {

    @MainActor
    func successfullyFetchedExchangeRates(exchageRates: ExchangeRates?) {
        guard let exchageRates = exchageRates else { return }
        view?.setExchangeRatesData(exchangeRates: exchageRates.rates)
        view?.setBaseCurrency(currency: exchageRates.base)
    }

} 

extension String {
    var isNilOrEmpty: Bool {
        return self == nil || self.isEmpty
    }
}
